Return-Path: <dmaengine+bounces-9023-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDT8AqVEnWkMOAQAu9opvQ
	(envelope-from <dmaengine+bounces-9023-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:26:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CD1826A7
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6919D3025153
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA642EA15C;
	Tue, 24 Feb 2026 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LrywmLTD"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF731FE47B;
	Tue, 24 Feb 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914371; cv=fail; b=LXIxjksF/vcYyql1JSiU7XE9di8ZQdgs/jtlQuz0OtOXq9pprLfJjAvhkFbzS1w1XxsQuViaaAfRrUmAfwZtcn8HamW0KP4MnbHfrkOjUuvJWrb5ON66geindyZqEIKaPMhi9Ik41//dW8v9W6NQyLIdu5kmkv7qQbRJ85Zek8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914371; c=relaxed/simple;
	bh=+gJKye2q8kEAgjZ4DmnRWNbbBuFh71iwFXvUYKd9eZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfC7QHmYAF/QWeQ9VO408lCSglr7Iq2LA9QjNinuknKfjgAsA/Rv3Xw3WOdT24/BXgi3HxsLOPyU7N10XADj1LghKPDXarYcFvXfX6EVIM/ECrZr0XYbXr6EANJ3kD3STZDy6pm7a0H63ODsR79rFhECa5hee6ovP5i+nV+FC2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LrywmLTD; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIbhN7g8pYag5Tm8HlePSoQZYmtRsPqLHWUlUiI32CuLfgVCKWrF7XJOvZ31fLn05OXKkUbh3G7311zyIToxZM67Xe8Sn+KRjSuHNcqxxk45RDRm3tqIWQh0NdqO6Elv493eXqvExg90T4t891ZEnV4t+NTXQXii1enn04fDyPTLLO0LWS3WMdG2K1GxmkuN/wcHKySBqaI9Qid4Nu4LCVtbJifWqR8hxnJlgWM4ajbNTXAlo3TBCQHAveyA2/D9Q3f7AXBi7twbU88ZZInDnHEj1uP9J3B3A8OE4kjt7xsJXRMhYCBxy5hrXFvdwoqp3MEUbwrtIu1bBsCQHbXYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lxtAqfuTr/27rDxq2nbcVQCkso8Hr4HkOvGiLJCmsU=;
 b=TNXW4S2lSmmUfuVHI2UEsjN0ZRpgYdnt00douB07jsPXatDAA9NDAqr+HplOox+hbb7Q5HkDglVOK2AB8L3tTHl8iLWcfcMoMcKKM4YzzF7ov4qKIpfhpu0iinJOuwW3IpFAiHpEKM7CYWD1eiz7DALwhokioFjIqiMnCNyCJYliW68ve79k5pDJ2tsPf8ZKqZajHotMmgG1MRMEB2gQS3IGnISRjmcEPKce4kp4OTa6F3H+ckqn4shgMMPYu1aM/aVRne6DTeGdVxaiFTWoZtuVIS+pc9/ts30+6I7NZteKu/qJm3o1dJRJ6eXueCpM5788p4Q0fACQwlEvreyadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lxtAqfuTr/27rDxq2nbcVQCkso8Hr4HkOvGiLJCmsU=;
 b=LrywmLTD/dVuK3iZSS6ne8EsV5TciHm9SIktFgCKOZ02zR2WZjAfTRWhCp9lu/HapRD5P4FRGefJ/7b74K6yNu0ZdRYv5MprC8As74LC/3YMl4/zjKR6xmqOgjf1KM09DOWZuYr9ZkApFKqlUyXDWihljIKc6RyeuL03igCqOI6T2wGH/pN2Ywco1BZlvvDvDwiCPUBIWJPb0Ckcew6iEjf0A4wmO80aigvExqdTz4Uvwm/hC9DbwrF97b4Gai0V2z18fiTFUTKpyZAcdKNcIbEdRFjGrKHUA/fCPYfkeVfGVN7ShlYaL3Rvl4X6rdvFrwhajJt9rP/aVvmBv7Vz7A==
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 06:26:05 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::dc) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 06:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 06:26:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:25:49 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:25:48 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:25:44 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Date: Tue, 24 Feb 2026 11:55:43 +0530
Message-ID: <20260224062543.47660-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aZTG8af4O-wosg4N@lizhi-Precision-Tower-5810>
References: <aZTG8af4O-wosg4N@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f27304d6-5271-4a53-f276-08de736d9670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dnq03Lem+DYPAiUJnT1dVxAlZn/4gtIgR9efRxgdbpwTDGxRLHlbze5iVpGK?=
 =?us-ascii?Q?oVqzjbgfcKaJRTBET71bH345tXAML/5OZp4jmqYR6/0Un2uahtllGzXVWVWL?=
 =?us-ascii?Q?AmazUT2m5B97iQ7o6Zd/fPUKUtfbNmX9H9+BYdWCqk/EmIKWXoGwLpbYaPP/?=
 =?us-ascii?Q?FJEo+VLLsN1nlN53w4hask+WDN2o8dI9Hq3RpeCD56QBc5cRJIawqPZznCLZ?=
 =?us-ascii?Q?b0l1Jturrn6rr95ufSpVHkWrt+/Btij2hnmvxDfS95Zww6ncKhZlxyV20ScQ?=
 =?us-ascii?Q?5SQw1yO5LQl1b9HTwL6oD7qgJCPcukYsE9c1KzaphnLF9x+BKF6z3BHzjXoU?=
 =?us-ascii?Q?2auhlXuL5UQfSxKTXHQpI00mFKI6X3GyN7UT59dISy1m462k/d1btyePErv0?=
 =?us-ascii?Q?0Ykxc75nWBg1ShxWNNMZabYwzgRwElLUG1d9oDWt7EeYuv3VPrJ1CLieaTRY?=
 =?us-ascii?Q?qrGATGUi3CzD4+xM1z2IcR1231aBmcw7quVQpbdUF4JUAPMe1RhVwg/yoTmT?=
 =?us-ascii?Q?2dyvMS7/gvxWozAk4ow1AnvProOaQNLwgowbMp513auVpkZ7Sp3tRMP/zLpI?=
 =?us-ascii?Q?tq261dKh7hi50Oz5JnSOSSxwM6h9jP7sKz6IEOgGIE33bIlHoD/GOxAEs5U2?=
 =?us-ascii?Q?SHrm0Zx76KNNiNKgwTgq9ifIjF4uOjTxMIZBf2+pjCa2fdu5DX0YeioOvhcy?=
 =?us-ascii?Q?e4nm/04g4pdnJBKTLqWPZBrJLngwYPz/RN7QUWrp5DxRGBRBmmXktvkc8qSE?=
 =?us-ascii?Q?0tAYJAPXLC+DAFrde74KHPGJwN1TJZfWU9dt5U0F7BSmfB6o3+HoyUDBL1Bj?=
 =?us-ascii?Q?G9MYyuxI0i92+8Qh3dKgIDlAIxeipEqN2KvUz9YMI/TZiKdwXFhhNabdsgSN?=
 =?us-ascii?Q?msN7tceAHEVEoWLaTKcU9sW0BFx6k2FplXLanXkq+FtPbCyuRQxNu77Gc0Dz?=
 =?us-ascii?Q?H5Xg9Cn9PdFtr6D880qif482IN+1i0wfgDUMfTpztlDTWR7UC1tn1+tHDznc?=
 =?us-ascii?Q?jDM5RTQYRvW/bWSOdwtXgA2VrJ4ZiaoSxDgPgq1dp3bs7xEdHwFoBgSKJklm?=
 =?us-ascii?Q?ycaVjzGrwTpLdAyiju7p74JS72mtxaHP/UeVyokjHNJsroXlPY0I2Kqkw0km?=
 =?us-ascii?Q?7DUkssmWWKKqzdWQjpOYmAu2YtWW8OZd6KYGaRo9PrKL2RFkVptgikexF7vw?=
 =?us-ascii?Q?JEaFJYp01CKKftNoehykUMQqJV3uXCWkRZjjTbiUzc6spcqo8jJCiQVjNMTc?=
 =?us-ascii?Q?cBKUbSpO9cXAC2czvtW69jM+wiYC4ZX8a1KPog+ssn77lkGkZ9wNPt4tZ6FO?=
 =?us-ascii?Q?tJQYkWTBEL1XEXjUyFgXwa0RKHC07Wd6Lbw99q6rhnQIiNYN5BS15bJKrB+V?=
 =?us-ascii?Q?kk8ANdqvV1lhtHH3avGvwBLgvTAFkgtBfSEZJ9IHR2R6kychR63A9vFrcrgv?=
 =?us-ascii?Q?PiVKFYq/8OTYplBal3v+kYYom5YTaN9p0czXqwxi3hk8vcJmd0PW7oirW379?=
 =?us-ascii?Q?FIwTLAV/ofnM8JagZd5PuSbKq+tazqF0eJjhEAnGsyyhjhRH1O5ysO1n5Ryt?=
 =?us-ascii?Q?kMbfdxIihumWke9UKl8fPO0cSvIinrXJaAFKp0Hm3dJ42QBPSHqTOgPy57YH?=
 =?us-ascii?Q?UTK3O/xMUsETnjQPybd+VpLCMGDw3+qZzpaefYsYabq4LiwEtf1rjrOlKakk?=
 =?us-ascii?Q?0XmltQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SiCOb/onR1OcX0nj+OBP9iZbtjVaSwBuEMe/FsGbAJgNVIM+FYrEzvaHA7+wEY4MF8yBshBk49Qmi8vQMZSMj30nzioeDg9z2WEkWJmSi2Q25vk6JeC5S5Umc6ZCM/QSGXbq1APHa6KLL01dx6WS7dTauL6O8QjtLT4njm4zxav7JafN0YV18qjtE1Nbfet5WF2StHB0NsbEKTQZ9ObrYul87eV9neFwSQX5hPVuDgac6OW9SyBwT/wrJhcpFracoY86LLY3o+viZ0OA2rDtXM89IPmIE6xY0GiAxeQF3ZtR7/0beNiuBNzg6e+yk2YWHBTN1IURUOX5BPgZYuJIWZMvTfRhXb03/gZZVJI+RoRi30pvOwx4gVpUaKclAFCvtop6ZoWmBKCETHLyISB42Q/5Pdgen8vZfjlor5QDrHvc8kFlhiPzLJx3qlTSeNAN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 06:26:04.5401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27304d6-5271-4a53-f276-08de736d9670
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9023-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 636CD1826A7
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 14:52:17 -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
>> Use iommu-map, when provided, to get the stream ID to be programmed
>> for each channel. Register each channel separately for allowing it
>> to use a separate IOMMU domain for the transfer.
>>
>> Channels will continue to use the same global stream ID if iommu-map
>> property is not present in the device tree.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>  drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
>>  1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>> index ce3b1dd52bb3..b8ca269fa3ba 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_dma.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>>  static int tegra_dma_probe(struct platform_device *pdev)
>>  {
>>  	const struct tegra_dma_chip_data *cdata = NULL;
>> +	struct tegra_dma_channel *tdc;
>> +	struct tegra_dma *tdma;
>> +	struct dma_chan *chan;
>> +	bool use_iommu_map = false;
>>  	unsigned int i;
>>  	u32 stream_id;
>> -	struct tegra_dma *tdma;
>>  	int ret;
>>
>>  	cdata = of_device_get_match_data(&pdev->dev);
>> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>
>>  	tdma->dma_dev.dev = &pdev->dev;
>>
>> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
>> -		return -EINVAL;
>> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
>> +	if (!use_iommu_map) {
>> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
>> +			return -EINVAL;
>> +		}
>>  	}
>>
>>  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
>> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>
>>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>>  	for (i = 0; i < cdata->nr_channels; i++) {
>> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
>> +		tdc = &tdma->channels[i];
>>
>>  		/* Check for channel mask */
>>  		if (!(tdma->chan_mask & BIT(i)))
>> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>
>>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>>  		tdc->vc.desc_free = tegra_dma_desc_free;
>> -
>> -		/* program stream-id for this channel */
>> -		tegra_dma_program_sid(tdc, stream_id);
>> -		tdc->stream_id = stream_id;
>>  	}
>>
>>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
>> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>
>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>> +		struct device *chdev = &chan->dev->device;
>>
> why no use
> 	for (i = 0; i < cdata->nr_channels; i++) {
> 		struct tegra_dma_channel *tdc = &tdma->channels[i];

I thought this would ensure that we try to configure only the channels
where the chan_dev and vchan are initialized. I understand that it is
not probable in the current implementation that we will have channels
which are uninitialized, but I felt this a better approach.
Do you see any disadvantage in using the channels list?

>> +
>> +		tdc = to_tegra_dma_chan(chan);
>> +		if (use_iommu_map) {
>> +			chdev->coherent_dma_mask = pdev->dev.coherent_dma_mask;
>> +			chdev->dma_mask = &chdev->coherent_dma_mask;
>> +			chdev->bus = pdev->dev.bus;
>> +
>> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
>> +						  true, &tdc->id);
>> +			if (ret) {
>> +				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
>> +					tdc->id, ret);
>> +				goto err_unregister;
>> +			}
>> +
>> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
>> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
>> +					tdc->id);
>> +				goto err_unregister;
>> +			}
>> +
>> +			chan->dev->chan_dma_dev = true;
>> +		}
>> +
>> +		/* program stream-id for this channel */
>> +		tegra_dma_program_sid(tdc, stream_id);
>> +		tdc->stream_id = stream_id;
>> +	}
>> +
>>  	ret = of_dma_controller_register(pdev->dev.of_node,
>>  					 tegra_dma_of_xlate, tdma);
>>  	if (ret < 0) {
>>  		dev_err_probe(&pdev->dev, ret,
>>  			      "GPC DMA OF registration failed\n");
>> -
>> -		dma_async_device_unregister(&tdma->dma_dev);
>> -		return ret;
>> +		goto err_unregister;
>>  	}
>>
>> -	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
>> +	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
>>  		 hweight_long(tdma->chan_mask));
>>
>>  	return 0;
>> +
>> +err_unregister:
>> +	dma_async_device_unregister(&tdma->dma_dev);
>
> Can you use dmaenginem_async_device_register() to simple error path?
>
> Frank

Agree. I will update it to use this function instead.

>> +	return ret;
>>  }
>>
>>  static void tegra_dma_remove(struct platform_device *pdev)
>> --

Regards,
Akhil

