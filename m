Return-Path: <dmaengine+bounces-6519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFBB5825E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7956B1A204F5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443981F419B;
	Mon, 15 Sep 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dmPA0rPi"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8F27A12B;
	Mon, 15 Sep 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954701; cv=fail; b=TXRRZNysTX8gcqHc4W8P7QD9Uh7GvxjP3ONtu6ufV//7gxm2cYCMDBIWwmHLi7tMER77oeYpQkNEJGtbkB/mDdSY9cphcsMnX0R/Um6gZIY9KDCUGWijaMyK2zXQXLVu9z9E+mjYclRvdKXE6MIn4mOMpV1MvIrhOlyXqW8stBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954701; c=relaxed/simple;
	bh=+hKdDxP9W/wyXyXZ/RzIWKW4DzN3NIdNGmDy1RnnWPA=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMY8olNFamW2U6kAzBlpXXq4XR4kWEWRQTUQokvrwVZCYImL7mcPNmZSqhYuMT2An3MVL4sh/viHkQ5/VAg4aIoNt0xTCIyojCdtEfmLGEWLzBX8ABosqa+fFNX2zyPz5KIs3PBtsHfGb00zbX/ci+WfQJ5iyCYiDXSVeK1zj7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dmPA0rPi; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB8uNV5CewwAl3Et0NPbqos92SAQx3jArPFcuE86Tos87jeCCHnJwyb0/QOZssKzr8T5aK/4pbXxXBAI08uCaVxd6crWlDYcnYFB6qBP5sJuXvz+LndsdaQ3I3AKxNj75lrkusyBrk7FLzEFMgb+YbceS8WYZHDlq+nlp9P8kXEDe9c1RDEWMW4F+VNrYL/7+7ySGpNQWWxQdI77MIzcPDR8MV1QH8Vw5c7cqV1g+fDoCWij1eGskR87ScFfewjQt038y5P+m4Y4L8GKYXbyUaCTQDg7tT4vAd8ssE2nDi1OMuXAy/nkNsYqmMahjKHjYSoZr3GtWvvOAs/+9G8HpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5mmchZSYZ6jbvl3czw9xBoMWekcrbR0LwdH96ObZj8=;
 b=qYkKKFc9NQ6AljE4FhcytkCRt59Bk1geylOG2NMHF+fGRCy4raIhorjiuO4nLrFKdRpVGDRfX6Rmc8j0sqdVL17G36+qeMnBimNlVs94PkwNoEL801DLGnsk01PlVOvfHla4InWQNDLuhJMBIOAg5HHDmPbEy/r8HNg1HrQscZ9D2Qwj/g5sukYhXnfvI4/QGYPCQ5NTLzy+OLn565jAx4+0agywxeSfv1SaLomIa5h3nb+ITHRZzY5m5Y7/3bFOJu+8WpT3uUfrAvKeIv6k7SMfU6EhvWVb+94oPQEU3K73q6RrGaSuBFEpMiHV7AGclGle/4khhECA+NELkGUfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5mmchZSYZ6jbvl3czw9xBoMWekcrbR0LwdH96ObZj8=;
 b=dmPA0rPi0cCgT/B2lctCdMeLncns2ewaCxzWpF89RivSZykIRqycMtLlS3FJiCHB7jJ51A5zLWPaFwBbxXRZnQxQ5syI4h4NyUrRlBfQIgfsa0EFJ5ka7HWEGID8/Ifb37lJo8N+uxf84yf5dk6HmMgnqc3FExw7aoEfCcgtLc8=
Received: from DM6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:5:80::40) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Mon, 15 Sep 2025 16:44:57 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::b1) by DM6PR08CA0027.outlook.office365.com
 (2603:10b6:5:80::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 16:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 16:44:56 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 09:44:54 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 12/13] dmaengine: sdxi: Add Kconfig and Makefile
In-Reply-To: <20250915160856.000005bc@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-12-d0341a1292ba@amd.com>
 <20250915160856.000005bc@huawei.com>
Date: Mon, 15 Sep 2025 11:44:53 -0500
Message-ID: <87plbracmy.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d6148a-81e0-4660-c5b8-08ddf477339f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MDO4/Bf/3gd+AYUXe6tlbQoAQ8sTL8pep9AUUxvNIFl2riK9mjuquUHSMZW?=
 =?us-ascii?Q?w924qjphu6skMnB3GCXSrlpzy37zn2zOJNGhmC7c6UF3/6BWryeKF4ONKp9j?=
 =?us-ascii?Q?XZ87FSehicf5dnP/1JY2zaQxVm8gbCM9m2kqZq3XYUiXrhvlsyBh08OAB315?=
 =?us-ascii?Q?JUvPDI43hoT2jNTunPXocIDo+Irr1FBQ3CmMh7HgAsJkFbDGgRONHJRj5KfW?=
 =?us-ascii?Q?HGPtVqLW6ElDJDfRdd8NnQb3tqdCRaSfldt8XLtFuEaZyjx4Rv7yYzwfbL2Q?=
 =?us-ascii?Q?dMorYv7uNJbzBbgwygqkjhnIFZ1e6AJ6NEKvau/6W4QluiIapWjzQII+hu5L?=
 =?us-ascii?Q?6AZVVHdYztGOe7Kwa9XB0E4g/h85aXP79FiCq4ifH/DMq1mDXpvQ5woCaXxh?=
 =?us-ascii?Q?Cv6c703PqSm2nUL4DBSJHijUO1g+tS6mno9FXoh14UoXayT4reCvTnMozp+A?=
 =?us-ascii?Q?Ci4A8g8AHP7b/JTUr9TDmh/dxyjKCz6PuHsArpYAuCNaclc3zXL1iLIp/ikr?=
 =?us-ascii?Q?hKcX+JcRy/2Xxmw9BfL12g1kiSYklxhTQVinV7FPXMjhRdB9klYFEOYuhxRZ?=
 =?us-ascii?Q?PvbrjPJucSPOsyP+h/2h94S6zUSRIsBRYhNg+e5fQioz1tw8lbY3bakqIAbr?=
 =?us-ascii?Q?+enN4ZwG7dTzKOfNDZsEJ/tCpQElgPBePuC8J6x30LicXLH/JOhRyYTaZNLb?=
 =?us-ascii?Q?Y3vT3xygJ4HVxiNtBqZeWohoOs56uFlyHnfHeApRREFtkPHYFXh9BZpvUn5k?=
 =?us-ascii?Q?ZXgttSA0RoelnJOroe6P0yY4at3Nsaw99pW7QUJNkHEJnvxlS1JdfSXgi0he?=
 =?us-ascii?Q?QuCzt5mejcO+VGXjTs/lOebaG6CxS9mRO1QYnATgFDxXV5CN5ZwIzBWmGVTc?=
 =?us-ascii?Q?nnEhq4C0LX1DzEBxFBcRqdXWXHSQZJWkR57TvsWf0w6COlt+52BdafGPp1zF?=
 =?us-ascii?Q?NJQw3Gn9rewursOnvmHqQpOqySK0UDeol1ynSfGPEZzHUqW03wYkDDNc5+ZY?=
 =?us-ascii?Q?US5Z3hAosIril14mHu+nj72bVtnQ7iTL6EBdAQSry9sHC2RU/e0ozjNy/NKe?=
 =?us-ascii?Q?4msezMQQYNftfLseBqV8jtod+2caKD99+37nkUjfG/hsdbJRw2h5ol1dvi2C?=
 =?us-ascii?Q?qw0C8g7wSUeFFZEL9eIwlVrG5/M4s7LbtVJ/Vyw4W5Mh1ooI6Zz+KRkc1qQW?=
 =?us-ascii?Q?iQ4GEyIJdl/SdhOppBKS6xujb38hKBXsd+a1Bt9FxQE+jInvQLeetS2+y1gu?=
 =?us-ascii?Q?tDyRuESu3pjXZ3CWif+N8EqwcgyUHRQTLjn0Kr2ATSw4yYuxmiIDG6Xbgd81?=
 =?us-ascii?Q?wXU5LY9DD0kD5JpWtV2XuZe8+hbDcxo+kDg4ARZ3JILEPoksZtMvvzBGTQPT?=
 =?us-ascii?Q?/IsI2J/M0+aWH3V55Vs4usUAxdKDu/sSG5PgMPO6IqMFi7nAaEAJq0LnzyVe?=
 =?us-ascii?Q?+3q7i3v+u7N9CjbKa/V+lF1m5r+ThTO7hX4pb9Bbu9sfh7zf9uC2icJWEgob?=
 =?us-ascii?Q?UzAyOFzJd7fD4YiDSYOgscAed8ZlF51TN4di?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 16:44:56.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d6148a-81e0-4660-c5b8-08ddf477339f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Fri, 05 Sep 2025 13:48:35 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> Add SDXI Kconfig that includes debug and unit test options in addition
>> to the usual tristate. SDXI_DEBUG seems necessary because
>> DMADEVICES_DEBUG makes dmatest too verbose.
>> 
>> One goal is to keep the bus-agnostic portions of the driver buildable
>> without PCI(_MSI), in case non-PCI SDXI implementations come along
>> later.
>> 
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> It's up to the dma maintainer, but personally and for subsystems I
> do maintain this approach of putting the build files in at the end
> is not something I'd accept.
>
> The reason being that it leads to issues in earlier patches being
> hidden with stuff not well separated.  I'd much rather see the driver
> built up so that it builds at each step with each new patch
> adding additional functionality.  Also avoids things like comments
> on the build dependencies in patch descriptions earlier in the series.
> They become clear as the code is with the patch.

Thanks for looking over the whole series. I'll plan on reorganizing it
according to your suggestions unless Vinod expresses a different
preference.


>> +ccflags-$(CONFIG_SDXI_DEBUG) += -DDEBUG
>
> What does this actually do?  More modern drivers rarely
> do this any more because we have nice facilities like dynamic debug.

Yeah after reviewing the dynamic debug doc I think we can get rid of
SDXI_DEBUG. Thanks.

