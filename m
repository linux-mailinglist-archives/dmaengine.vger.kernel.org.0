Return-Path: <dmaengine+bounces-9221-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FysM2YXp2m+dgAAu9opvQ
	(envelope-from <dmaengine+bounces-9221-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 18:16:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B141F47C7
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB773302260A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A074CA28A;
	Tue,  3 Mar 2026 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N6Vu+eRb"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B89492502;
	Tue,  3 Mar 2026 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558114; cv=fail; b=SwmB90AMLtCO9COlF7xemCdVNcX/8Ebz5uOPWZUOqjC8vJZosbz6o4kbadq5yIijlEG+ohfmCfRuPpwFiqNF8ZO4rJJJ0vcS5H72iOgvX78/k7Fm/tHGWN4I11rjGapsKigPZ678Lh/5l9MbM0y/W4yTA+B8liyTb/Wgx9SH0Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558114; c=relaxed/simple;
	bh=gt2iwOEM5F4qJPYqAlw5opmeTm4cGQKiLChR3ubj2bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8+GgxKKhRtOrr8+UzxhgfYEhiFPQeDUOStBgbEW9zqiCnSBUDmeTFjJttKhyxGZsBqpLiwZUeSDfgAmf30LJSZ970dzei98XkNKLMKvLnbxQUeEQHB+R9M1vAX1jaQa0Bkj+qN+Sob0sUpNOphlfe5Gu02gT3DrRY6ejUj2ISI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N6Vu+eRb; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OExZu581d4q3aKHaViNeSWEaYNBa0oMjpEm+z6l21+AKLE1w1cVUn5T5JBlDc6DvQZXGibyUC8wS/4BeCX87O7gHt/oISx50T6qCAR7AWu/dGQCPf4UkZo9bay1IUCYrGY/w8qHlZj4LCxxxKxeygGw3xRAwXYFc8rOU8ElPi6xr7F+Y/uDAwJdAzO+nKrOqNgUO5EyI8M8u1LWTI3fv441P4XgSjcOXg03PuRKLm4WylWN9Cc2TPrPAsS4dP+P/E5wLStaY4gxdy5jgUQqOKLsCo+jxnlQ3K4ItdyG6XawbzHtjdFZ6frimvr4yegLEvoPX3hbPFFzaHXXWBi8fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIwluFViwsQQ4xnviU96FUFBO/p6vdLbsAkF0u+52HE=;
 b=TUD7oyBHlancEcQHnbvcl8RfSHx1wdHSBuPKsl9m6iewuMvaypa9NN8FZacKPHggn853OhuKnKgUg+jVrZNmVrESOYBnMHww2jyJhAsMZ2c8mafbl14YPSNZsdHb2jkWIlFPDM1mcGhSIp6nptxaIdGnRChP4SXxPKGhfSrWOISYAL0XQfIBIT82U9tq8TtH3oFjQjWz+Rs9UQcE9hgdruIUi+jxkMN6kcyKzRj3WX1MXb0i+x7QcdOqacMVx/dRV2Kflf7grwTKejGUhZos1+0vuZgV1JkxyFaeCzYcs0gQPQ9GVIcH8TCV5gTANqP/KxQedS+jKYLvL8+MFejZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIwluFViwsQQ4xnviU96FUFBO/p6vdLbsAkF0u+52HE=;
 b=N6Vu+eRbg86iXCRYcmC2ozPiLv9e7jbq0GxIV0AAPPdc4tfY5f7kQ01+k3pzUIBGHCN0IqZbBn4cPgZsjpBPSU2LBduTkcsnFrO6ASyis3OQux1aG0oSdLLJRh+FkNUUh9cfYpiPOsvLzaJZRIOZ74raSpLfQRtjtZf0p0xO4wp3K2tzpgmcLCXlnwGBoFowrakW1nhbX30iAUBpF0R10j6LUexnPTbbsKZC5Frsddxi6n4zC9GCyDpe9UCYQsq8mq/81MjaN+nbo/7buBUqK+1yaG/9FfGSOSkIoHA3ORekaysFiTIXjgvkoF/xG27FXOxwer0TGbmlfNlPwN416g==
Received: from SA9PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:6e::17)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:15:10 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::4c) by SA9PR11CA0012.outlook.office365.com
 (2603:10b6:806:6e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 17:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 17:15:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 09:14:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 09:14:46 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 09:14:42 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <jonathanh@nvidia.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<krzk+dt@kernel.org>, <krzk@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@kernel.org>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 3 Mar 2026 22:44:41 +0530
Message-ID: <20260303171441.11545-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <28c731aa-970c-4ca4-93b5-e2cc57b0c119@nvidia.com>
References: <28c731aa-970c-4ca4-93b5-e2cc57b0c119@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: f56d3364-a844-42ea-a012-08de79486c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	4cm+5J+1Ee5UrZvTa3aoj5Eq2/vLccG8+7c8vjnQydlzW8TUiBTcMObQsZ0Oa+mpazNpzAtZG642oz0mZuZOg7iySU2tdV0QfvnScOlnQ8DNRyjDRRC8vIq5Boasgh4nMW3JGsWgJE0KMXxL9Yaz7UFoTgQbQVluLKpEKlnbk82MlWMx9scdR3Li8AAzXoyqxaW2NwR+fu+sC2IrreEBTXbpbDg/KkROe3Vkwc6pxavC3/sQHRRJSpmX88MrPPj9CZAPLIHQDT6r5AJKJKfFy3NZWY1kzl8eW8YjLwhQL21+bx9suJP3YZy2FqCq4LRICkCmLbfTI64eeUD78OEFkPcSIoHpDpaR6fYEhHI7w/aec0L2Lnh/gmR0b8hOEQEFEl0SRX9O5HQ7FT5fCFzw9i+W1hDsgVcZN1N0oojTgL5JsgcGulUhOl7yZbNzBy/1UZEsrHeewHycqGnOxGRv5PmBpllO976bQF2Tc/Ne9TiYYzDwj+CaDYx8N26M8Sj243Y+ilM2FBYCqwMnpWTEJLOPVyPwohRSTSePrs6cRKXWR5RN263qDhO+AccjrojOiYAE3Ed12Ykx2l1zOa9ok7OB8FS1zeR5VfxsAA0bPwzpq5d2lmnQlyim0yC4O/9ovNdvM0PRliMxqzc5FhTL6A24kLPK0owgyGcTi51LBwzDHcBGgWbAEdv+f5zEHbQ0tyUoMdPCytTceYGWVwsT75FKf502GS1cKFtlw1WpQWfgect4UxIhli/F+B8Ape8rsZXjHVH2RDUJMgSFlCG5KYqzU4jMMi0/DztJEg/ZtpcrXzW8BP2ojy7R8PzHYt2th5wOCJlrU710tUt05EbfSw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	grc8eZoMZsSLA4suersKZx9KqVxTWbBO5IKx31Ap/wuCdpwSrsW+EFzBSOp+A5tyCBG8lpYk94386+e7fZ41RdBDVgUifK56lZtZMnxZREh45vjYKrRRVokwIALARUghj3VnU9dfVD5XGqS8wLh5RDV+U++p8rDh4RlyYuT3AltQmAsE5PUtp1A0/JZIzFaPajQZMa0v9l0EDK5VUc45Nb23ArHGSek8hkdPjcXWwexc46VUWgSqJi2eHbILIm/gxqFzODnIkOnKW81wAElq/uASK3xMOMgobQFDWkCyVMrCn0syKRmVShVZxXnpmVlk4YNQt40yElPNiD3nBKFG4JED7BGAtpCcAB4Xt9kKIiKa4lChv6uBXlBeYcKO5kAXHDET1bK0/p6H0w1gMReOAiGhzw7i3wkf1Lf8+9mF6akSmr4yqUzhkAS0c1tYjYPg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:15:09.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56d3364-a844-42ea-a012-08de79486c73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
X-Rspamd-Queue-Id: 32B141F47C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9221-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 13:09:00 +0000, Jon Hunter wrote:
> On 03/03/2026 08:40, Akhil R wrote:
>
> ...
>
>>> Why is this flexible? If it is, means usually items are distinctive, so
>>> I would expect defining/listing them. If they are not distinctive,
>>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>>> mapping, just add it in the description how they are ordered.
>> 
>> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
>> it flexible is to allow non-consecutive IOMMU ID assignments as well.
>> This is particularly needed in virtualised environments where the
>> hypervisor may reserve certain stream IDs, and the guest VM can map only
>> the permitted ones. Shall I add a description here mentioning this
>> use-case?
>
> Isn't this already handled by the 'dma-channel-mask' property? The 
> driver will skip over any channels that are not in specified by the mask.

dma-channel-mask would not help if a channel is exposed, and the
corresponding IOMMU ID is not exposed. For instance say channel 15 is
available for a VM, but not the stream ID 0x80f.

Regards,
Akhil

