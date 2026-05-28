Return-Path: <dmaengine+bounces-10993-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BKuEqsmGGqZeQgAu9opvQ
	(envelope-from <dmaengine+bounces-10993-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:27:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A364B5F1463
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6519E31754B8
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0263E2AD8;
	Thu, 28 May 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dekqz2fe"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE73A6B9A;
	Thu, 28 May 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967439; cv=fail; b=FOvKcrs0oPYqCGh+j9c2Dsjiq/x2sP3RbSzeCGqdhzjrufXPa9NpfvgTFSZ+LxuCdyvQBmOlY0DQbzG2KF7GuGTfL+mo9Gxgy+Gn+Yc5yVks5U9ADsurHxIWGc/v8ov5VFQ3MbKsbJhvZYY8IAfvuRahxFSRtuE8ffEvtKv4wOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967439; c=relaxed/simple;
	bh=IjwRdmsNc4ifWqVqry3LaHcGfne0qvjzY04LehNche4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FATvibil1I0Xrl2+jWYa+oMAjDNO1o5KOaDL4cJD93TOkFrKpdf04f4/brFEYjsMuCcQPD5Q/1Ka5IKHUQR8kIRG9QZjG1cOslfBA30QUQp/LqobtC48GrywE5TB58QuvhnmCgmdhYcmC5czP5tMOX+3c9FFZBH8M8/cCA9Ibn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dekqz2fe; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/g1CBfYB00UnhG1UpILwHqesJDUtISsiAKmKRe2HSFd7XBtj0E/oq6bCEocvn9eXQl+kYzKKewuKGXPjGc/OUBUWdtTRbTSmbM5vy/wEfeZDJ6YvdUpKps6qZvlE8vwfC5n+9zlwePS1TWb9LBpjCT/tOKmq1KUTqA7IQtpr1J/8yI/K3sg5F5JhyOBoZcEjkloGcKJwKNGKCrHQIFhOHMa5UkXBAlHv+clAwNLKsTnySf6WwBwepBTf1LzRRXLEmFhA8g9DcUNhugxvPAu0qM5x3mlET2XsFe4U8ppCZmLUWKxb+OIAUpCYLsNZxNJgKQDJzRrhbrCnezghJZKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG18CYYOt08TVfMzKRbcufw6cJs3Zees/v2wCwb9jEA=;
 b=Nkb8pUQGSS77AZc27fPsy84z/oii1i4W4Q2BqxeYXiBDM9Utoe58z+IiWkIASxUtceh0LbEwL4IjqX5zD6m2jpFxSAuBcykVsXoI8OAG3d+7pUuw+3+u6GWqBXMWWIy7+HndF8jnOfBT+LpywKFQvWR5mUoqBUP+de9YtNML6mtdrT10OZVgruEYXKlTUjpPYtEwp4MHMPStBmx+SLFHER/VSQm6rjUTkayz8cQmz6fjvq6aiX6ahHD9VKNinT/p7y+4a+jHjSD6ju5r0zUfYYoHEq3mYC/KPOBmQhKY2exdQr+jJga6LcLVZ9vuCf6hj6nlMDJotu0s49d14X5CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG18CYYOt08TVfMzKRbcufw6cJs3Zees/v2wCwb9jEA=;
 b=dekqz2feu6spz8mIDhEEi7N96g00VCBqC/B7b1NqPDZqntjAHKJGl1YCQvzrxex49Madye6uEhTJZUc7Vv355X5ZQ5CG4qWy/mQw9ayQepPbw1k5gWbiwXO5+uEpf9XmnxAAq7SGTXjo+yhNv+QbxgXBblBnzf7yKa+lZiUV474=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 11:23:55 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 11:23:55 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6 DMA Device ID
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6 DMA Device ID
Thread-Index: AQHc7op1fDVEnlLv/EGPZJCsUi9oorYjSo+A
Date: Thu, 28 May 2026 11:23:54 +0000
Message-ID:
 <BL4PR12MB9482F5092DECA69AA62A7AB795092@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260528101202.1244624-1-devendra.verma@amd.com>
In-Reply-To: <20260528101202.1244624-1-devendra.verma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T11:19:16.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: 331756fc-ca11-43e3-4445-08debcab9a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 NaGuOEgZV/X98Gk8tv5tl/Gt7es6iRo0oh0B1q/BbGdo0pAtUG+PmbTUPeirc6h/VXoxuNAnsJ2S/xGRRIFm/UztFQEusqtFyw4W5dBA0GjvmqdQMMOhzFYBYebRDTMLdoyiTt5m5hTzBDJSGlyvmKFymFKhqCTVWKYbMXMtg7d8tWYXJzrTMTE0CUJveARa7Vkwd2t9fHia1ock387INQnaswMsuF799wy/OQo0RUeRWxvJtJ6LfoB0RyxjV2r4g8ELWZIlxBVPRAAfC6oPs1d9cqBamuaS3oZT9c8qgf6MqVgF2B7/5WodfxcQX0o1ptMaEjgBPsL2nu4m3/34DMxjEFTlYf+8+gqEbKtguSRVe9usCInvaBZpkTbtMLzUK5Si9MpHhG+eNydeStVLjZrxMPkQaJQmNNVjD6g+AMMp3xt0sDwaK0BNSWCOpTmEl1L+cDRjJpbcZuN6KwZPavc17j381JeiyTuCo6QiwgnbJx2+SeOeAbfSU5lLoDhlUXbvjbvtbndMb7GzbB5VVqpp1QBH3ZZgf4RqZmDAxjbNw1Y3yTD8pBopquIAVZm0kLL2UIF40SJx6xO3TbgaTL4a1LKQiF+Z6gQFgYrQzv+r+PIlasFl4niJvXAbsp/FkBng3wlt79QuanzkNzY2VlUPJPXDmxrOQ0aSF7K05SGGEcJiEUeb01wAW4QDZ4hjzu1eb8qyJHqtHk/iitB3rVuh0HGsVTQlY40KO3hZnVpPBGJp+6Vt2KRO1jjOOHM3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+7y+dyyi2L8Vg6Bipo6poRcC83cgFJ5RyT2xnJW0EY1yqLQ2/pgiBOFJ8fMg?=
 =?us-ascii?Q?TE/kHpoQI4xEx1CodDRs9uUiG6ihI3Wdj+kCbeJShCwBce7MnX2RHNKl8cF0?=
 =?us-ascii?Q?4Ow53jr7x7BkAWXWFtK+10Fu/mShjtYShT7guDdHzRgIw5kg2//Q2YdbfUbj?=
 =?us-ascii?Q?UUyekiHD0daNlYoS47dFkPYyr7sAw1IQ5FPS1vlzTntlOnTYSbyIWCl2aAYp?=
 =?us-ascii?Q?An5p8tRqiR8FUcS9svU5VT6gV1ussEzwWhmtRRInO0BShqA44rZMSFATRkjo?=
 =?us-ascii?Q?4I9azPizAq20q2bguy2qr0MhvdRigWTyCHt7s/HFDPETOBRnoAB8QHF4Czg/?=
 =?us-ascii?Q?l1GkOtdULbvg10nvarlBo6ZP4fYyHT+7ZNhw7LP6QOHAcpMmE2oPYEPjOSs6?=
 =?us-ascii?Q?njo6/8EP83opYc4ayHWalynC9+WRTaiI+5RLH8UtulfQgW7MSsSY3cScMquX?=
 =?us-ascii?Q?q/9qJsNd8sMEQCoWWAX3eRqSehS2aCJQ1FC+7Iq7FkeuMu6X7AhpnMw24x4+?=
 =?us-ascii?Q?yzySzjGInIapUKypNUL/+v4BP/Cl2CAVj8lIB/sKB7/LzX0ThoKxIIs1r4UB?=
 =?us-ascii?Q?Poxf2Oe4J4mCkf7HaSEvYw2WYhdYnN4tPfBcpETPmqiU7cJDaUKlyDiWJjhG?=
 =?us-ascii?Q?RcC6UrkdaQC9M5RBNm5dHiQNUd692W1ZKkjBbpUZyeeEezWYIZTYdVX8ZQet?=
 =?us-ascii?Q?v+L5Iw+VjM4K62zb9xlAA7HTcRV9aHOpTOvX/KinxIiJpX6piPsflx6O4xC7?=
 =?us-ascii?Q?YAhyNpGtrL/0Zz89OxOmncUvJkhzw/N+NFLAG/8X/ZJyx1L8xdIc6lWf1EsW?=
 =?us-ascii?Q?Ap+3fVOREm1vukir0ylktMAkiJJKzz29vA6uSIcLbQih9g/1DU+sYlX4qxFF?=
 =?us-ascii?Q?UZkstU4QZ8bNgBIW9BawBCLcrGgjJiSyyirKq+t0IGGZO2dYDbvgOzNXeZH+?=
 =?us-ascii?Q?d4ThZKFt2z1gNZsnlBLYxSLrhViI7FAa42Aw8KrHdn6SIIHMG19PQOL+kvLk?=
 =?us-ascii?Q?nNWj8bvyzW8B9B466/FX9wI10CL55vnr+9F3H1kUtm817Mb1Iw81JMh0LS1O?=
 =?us-ascii?Q?0IUXbRJsB1FOzWk5oPNLtevniZKfwcBdaJImNNllNE2sLb2o9Yv1snIihJje?=
 =?us-ascii?Q?W3uJAKOhMFoKWCn2ihL8GoSohft8r/lunwDWLrE0qiVaz0/P/T7xXpOniBIf?=
 =?us-ascii?Q?BKKaHNrafcLXj5jp0m5LqT+E40e34qWUtMknaVTi6rsTNGfnb8TlLPaKJYUA?=
 =?us-ascii?Q?qRdapJTA29n/HHJAVoehYut3fcWFymtKUt8hy0d8X8M2fYt+wEMpN/CLUwn8?=
 =?us-ascii?Q?GmxGj1ys3mzjkVMS7Df+HDmZ3XWxjH3IR1DQ888D6v2e26J289ovwC3NB99X?=
 =?us-ascii?Q?JG85lz2zTNSx+dTrPsoAGE5GWPpm0ymlbMBUFKmsjoVm+vxGNQPo8VfOTJvZ?=
 =?us-ascii?Q?cHJrEUY+awZ6UjPoCzTIzuiIKiFwEYOFvm75qYQR5GOuj1V5Sk9l/lNzCTiu?=
 =?us-ascii?Q?rqQC6wqG65LiGzMo1lc9WfFGkFaPs3hgFt8G8QWMUo/xms+sCQffnzqHiUIU?=
 =?us-ascii?Q?zwB0hiJ+f5KICVxPGgaJJYUmbwfWnDNJdvjX74DT2WsyVsc7RyBwRhM53F+b?=
 =?us-ascii?Q?dn8qv3MHpPsHf8N1er8o+YioJ79NS3hJXg39cKE8pCJNeh/4E4aBjgRIGuaW?=
 =?us-ascii?Q?lyqh5eKeKPLwnU0fJQiWl6RjmeWIhJ8k0VUyVkkPD7Jfsg1d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331756fc-ca11-43e3-4445-08debcab9a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 11:23:54.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh3UwkbXjAUcPZCkzSIlmGVIYC+1WmtChyH3FFik4nuUiYelBlGEZL423zZF9kOmP3lF/fKZvLSEQRsXbWNNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10993-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A364B5F1463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AMD General

Hi All

Please ignore this patch. This patch has some issues that's why withdrawing=
 it. Will submit a new patch.

NACKed by Devendra K Verma <devendra.verma@amd.com>

Regards,
Devendra

> -----Original Message-----
> From: Devendra K Verma <devendra.verma@amd.com>
> Sent: Thursday, May 28, 2026 15:42
> To: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> Frank.Li@kernel.org
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Micha=
l
> <michal.simek@amd.com>; Verma, Devendra <Devendra.Verma@amd.com>
> Subject: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6 DMA Device ID
>
> From: Devendra K Verma <devverma@amd.com>
>
> Add Device ID for Xilinx CPM6 DMA IP.
> This IP enables 64 Read and 64 Write Channels.
>
> Adding the relevant dw_edma_pcie_data to use all the
> 64 Read and 64 Write Channels.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-
> edma/dw-edma-pcie.c
> index 0b30ce138503..c5e041142869 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -27,6 +27,7 @@
>
>  /* AMD MDB (Xilinx) specific defines */
>  #define PCI_DEVICE_ID_XILINX_B054            0xb054
> +#define PCI_DEVICE_ID_XILINX_B00F            0xb00f
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> @@ -125,6 +126,19 @@ static const struct dw_edma_pcie_data
> xilinx_mdb_data =3D {
>       .rd_ch_cnt                      =3D 8,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_cpm6_dma_data =3D {
> +     /* MDB registers location */
> +     .rg.bar                         =3D BAR_0,
> +     .rg.off                         =3D SZ_4K,        /*  4 Kbytes */
> +     .rg.sz                          =3D SZ_8K,        /*  8 Kbytes */
> +
> +     /* Other */
> +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> +     .irqs                           =3D 1,
> +     .wr_ch_cnt                      =3D 64,
> +     .rd_ch_cnt                      =3D 64,
> +};
> +
>  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> *pdata,
>                                          enum pci_barno bar, off_t start_=
off,
>                                          off_t ll_off_gap, size_t ll_size=
, @@ -
> 547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_table[]
> =3D {
>       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>       { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
>         (kernel_ulong_t)&xilinx_mdb_data },
> +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> +       (kernel_ulong_t)&xilinx_cpm6_dma_data },
>       { }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0


