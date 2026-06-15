Return-Path: <dmaengine+bounces-11522-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ufewFEQeMGocOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11522-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B76C3687D80
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=NfoVmB0T;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11522-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11522-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645DD30D6EDF
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971D406802;
	Mon, 15 Jun 2026 15:41:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C764071CD;
	Mon, 15 Jun 2026 15:41:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538089; cv=fail; b=LWl1fxtgELq+sivhObDtf6fNeoBtyYGmsqOvPF1iOcM4vGyTWKAIhMxW/Z1gzUouUwCNLXqkTXbcXvaoGoSB50WI16zUslmbvdZowNJZWFdcta88v6ZTXvvtj2ATCh1iKoijVX8ixxLR96gz4MAbTfQKd3TreVpZPMSQzl+r+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538089; c=relaxed/simple;
	bh=4238jDaLXq+pQN7yxKPexIxug1FXYsI5svuXIYZ+VSM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LCKvwWZf2rGB1/tFtwyJVSgPA8FIvVCtSdXiqlEzRhUj2A1tTsnVHRJfpsxRXeVgrcSsHQ9JUHkAF/USY9iWsy6EnR1g2or6etRGxHV8oi6IlczHbhS2DjVUUfQXCY9cURFDI+p7dimmDfSgJtYWM2kL9t/DijOvODVVle8Qi14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NfoVmB0T; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzz/Dx/Il0twURo0ynP42/rlKO4NuHxjbciXbiwpaiXtv1XINpLUR/JBtsDTqk3L+EEaRKlBHUEzzvnHYXchaxsXpALml6s0xfljF/udnKM/zNmK9sSZa1qeTjudCENoE/DyQWmBrzY2+rj+SWgrgDbDm3bdLbZJ6x+p9APJwP9OIp2LQn78wkBCiEYFucWz/FjJsZfLE6r0ewvGH4E3JQ5C26PfFiqptxaYXzFQ1FMDJnOrkiyF9La+iUxeeGPHVMVpih28zwLSnvwrXl3A62kmqrrjX6KDPi2wcT8vMyPrKwPjIqHtc7DODw5JXsxVdSS19N9yka+HRKG7BCf22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vITdWucI3INEMaKEz0ahk1VoosSGYs/pvs2ELiMLGjg=;
 b=fNPf2aNQ+i6bIvRRGJGhgAZex6Lywq9ojhf5EjiiXiYWWAQDMQr8aMOyh7xBafB+Buwkg8ZEcoIVW0BrgZdNWvoJVC9x1E+RzrZ1bYqgEC6pGTXRMjptP0Q4c4OAhxgk3Kev/hnfxpyV7qjoXD3gm+pTrSBLYMkavRtneooW0V/cvqMtMFzF5UgprwlhdmOIHxLZmuOZowci6ocsxFZ1V38F7RfVmZeafsezcJN+gd7WjTfCy0bhEu4SUeyJjPzVlKto3L7rkSDhuY+XDWeO4U0NF5nX7xup2K+JrTG16HQNljOgqiAVPYwKD11yUCDztRC/OMJuXN/+AGCPti082Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vITdWucI3INEMaKEz0ahk1VoosSGYs/pvs2ELiMLGjg=;
 b=NfoVmB0TpAwx6b2aPdTjp9jMdf/5yl+xhZc6uotsAJTyh/D2Xy2TVVpETXWBI4A2hhG+aWnHNXhz6tp4NyWvpfkmKQvnFxg6ZH70wh8Z090Le+VpXdd2GKSN3Su/lIGZrPLh+S3XIAJc+oLcOb9KBZA94fI2DHzCdQo7Sg75jh8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Date: Tue, 16 Jun 2026 00:40:54 +0900
Message-ID: <20260615154111.2174161-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a01958-71dc-4b8b-d299-08decaf48cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	e4YjJXg6qKQNWt3SvOlXe6vG2WOof3NdisUVCtzg281bK1V5vTPv7nVMceJCUHdX818n2s0PohF4iLZ0IoVt8vModVPohEVHD30/1fGljfIK80PnW6vVFF6XwfSQ0ptfg8shMafJY0VQLXb4ekQP/Io976pO6Un8xSXYcZ2WdeJLppQ9knfFnBiV02496pgVz+KlkiOquUC9ibpXYqgQq3qzt/hdf+2peSzICsqjlaqGEjv8c/tHu7nTy5TAJgKVAR61WYJhWFsLNpHnfOz5jK+94Io5ygTI5R4vpLl3VkqRbOSb5gVr3/TjCMtrkOAGpbxcVYe7Q13fN0adcfL4RB0drY1ouqGzK+YuaYKEste1HBZsZu+xArZXtLyKjmYIfLPEkBfYWlxc/lr2hBTXqSuJlZL02JWZ6i2hca8CdYkGcxOHIEXREN6dSbHTI+ivZwxVuRel+kX7rAwKpj6H2GsNSsrVJLO5O7PxVaIaxyZFKDY3HW8S3Abph7LMoX5tBVANhDBq8lNCrBdxCA/blNOz2iqJLY9vY7soBM1TcO5nYOkDzvLEp0yHXvvPnz6SDlkAZusdjWX5jiEP4lXfAzalrZ3DP9WCgaJzrAPnDm1WxfpCJxYWWT0NHC74hyRHOgSYroQlEE6xxUygDnPOMzf5slpdznu4+iDAFVb081piW+EdyGN/ksWOJI93KXyxZfWc+i/qqu3xHKUyi/Kg5GH5rnHB6YeOQYeG/S5h+KU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zDFKC2cLxPkuNFGth3KqK00I4XLImc+dcYxDIV97TWBrqaGTO+1zmGJTghFp?=
 =?us-ascii?Q?gh85yQeEBTrRl1/IFIUDbWlWiqeawCRAK2zn5GQPbicN2Yn4wm5OJOg7mrkg?=
 =?us-ascii?Q?POklOlKDSiIO79dfguDJpwEFDYlk7ixcGhmqghkcevNBcAHqJKGet1OWvSNU?=
 =?us-ascii?Q?CbF5wwLGmBN86Zyk26qJTeEOK14ikcJwQ/swsDA7HwWHr+hPObDiYZZkQjvg?=
 =?us-ascii?Q?/LRg90eBccN8o4oitUjt3UDeD4KQmRTwJzPpur3HevgoAyw1wsbc5LijMmZ0?=
 =?us-ascii?Q?dC+q8J18FcK8Utlg9ny57hKg2LAb0Ba3GAIrrhlFihpnKg9/QbupSpWuvddu?=
 =?us-ascii?Q?GllXNKPwPUsOOLJfp2Q+JuR68MxttJJKfpKiy/pmgHOVf4VRkRHIg0gLe4+z?=
 =?us-ascii?Q?NlRPXFDwvEbAcO1mz+4NV1HLz9jS0V370lxvzKhZVsU1pVIMMYUCAiRczq8G?=
 =?us-ascii?Q?yFqGxgyYPYjF6ENkVbAJ094bAIllgnkkFmTwwEGtLNHPYQD974W+iS7pclW2?=
 =?us-ascii?Q?TrJQW5XV5qjnZ5aBC0WDTr9FPinhCu6cNG7/0pXtHHbaeMzGkOp5T/iq+twp?=
 =?us-ascii?Q?5YjuFrzMfXfFel9+mhUgTHPZWGqIsIRjRvpROOaIpgDrsNPNVGjUFf5GNbDV?=
 =?us-ascii?Q?MOKg4ZzrvD59nakC+VO0HW+45JfNXGFl3WGIaSxLkedKGjs4CnyYll3bnXLW?=
 =?us-ascii?Q?GTcFCy8cMMnvshEa1T0L1dxL+9KgkNL4u5DMKWjj7EL8n0KLPTfgFC+Rk5My?=
 =?us-ascii?Q?rU80WLCeYDPAZFDhdCJ8L27VS9VzUGOdq9n6EpqwVvv+74lYJGNMj51q/os3?=
 =?us-ascii?Q?4N04nNONEpNzyX4Hl4+19NtZ25CouKR8ckW324HIixD5e2SrgipJ9VTAZ8xs?=
 =?us-ascii?Q?Wprir6VxNAA2cSyQYelA6xNqyCfHblo7JoB/LHdzPdDWdSmwU3+2x1bVZGHp?=
 =?us-ascii?Q?RLLGOSORqkfAmDHL9zy1yzYEiLrTfhgXtY11jGPKYo5D4bhyYLw8mYXVhaCo?=
 =?us-ascii?Q?ekRr8HgoY4FzEjxCh+LsCHd3jjXntrAQ8Ky7ctakf+P06b0bvs8JJMFkJc0B?=
 =?us-ascii?Q?4pLXn6RX/L5Og488OokgK4Xy3EewucjY7Fls6Sud0AxC/zpXCxCb2kjk75Zf?=
 =?us-ascii?Q?1iCk5FEHgRtVk4hwYI6ZbsF4oXxnItEGDCxLa5AmXbgZPqGwoUZBmzmqCZmG?=
 =?us-ascii?Q?grfcdhOdKCiRnqaeXiMiz6inW2UpNFE+bRZC41Gj/FASDZMtiborsHf+zdFg?=
 =?us-ascii?Q?IDXHf3ZsSxsJsxLJQDpborjX9UfpgnGQBIv6HDeHmGgp7dFPakjF18mS2vhf?=
 =?us-ascii?Q?QukBvepD7zmER99rboEkevuFEFVCIMmvMRdRZG6xC8TJBqZQsEfHJkF4ghQw?=
 =?us-ascii?Q?wBgD4OHWGoWZoBKvLKkdDWKsE75opPpZE+bdwTrEEUhlBONNLwMu2IZy/ddU?=
 =?us-ascii?Q?lOlLg0wVmKyWICp25VpdtvjldXGXfWXEWbN+04lFj7W4bsRaB8JMcwA0kmEp?=
 =?us-ascii?Q?a2Lj6cStRuTX+ph1VPAuO15rlBkB1YNyiCpPEUSw5r9rVwBeQ2ZdWoCCdID5?=
 =?us-ascii?Q?EqA1/IH5CJa4OvS/TfNTwDOKxXccagNtXI9XctEnOM4wToc2V47fJu4CRdJY?=
 =?us-ascii?Q?2cDQAHCIz1f3Llouj79r3R59H6ltrgWFPUpneGy77b2ApxxI5CJB4dyQnbrf?=
 =?us-ascii?Q?8mQP7I4oqf0Jp2Cw32WRQRrB/98Mmta3epT/SlmDN+Wwu/xBn6ynwvsqncOn?=
 =?us-ascii?Q?QyfKz54LS4YNVa4u8yKO2crRwtJty61h+aZpHBNb5rEzP48q/0Pi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a01958-71dc-4b8b-d299-08decaf48cee
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:21.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m43ElTOdB7D3z4LDrTAXTM880ULxcY2gr8pq+oBRsM3cYQqmrKT7jDSYg/IP7Qd5+CVKey3vd6Ore05cyfV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11522-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:mid,valinux.co.jp:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B76C3687D80

Hi,

This series is a reworked version of Frank's earlier RFT series:

  https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/

After discussing the HDMA test results with Frank, I am sending this as a
standalone series that keeps the main dynamic-append direction, while adding the
fixes and HDMA handling needed to make it work reliably on both eDMA and HDMA.

Several patches are kept from, or based on, Frank's RFT series; the individual
patches carry the corresponding attribution.

The series has been tested on both eDMA and HDMA systems. Both completed the fio
test set reliably; performance results are shown below.


Dependencies
============

1). [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
    https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/

2). [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
    https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/


Performance measurements
========================

"Before" means the dependency series applied, without this series.
"After" means the same tree plus this series.

The fio test cases follow the set used in Frank's original RFT series.
Each full fio test set was run three times in alternating order (B-A-B-A-B-A),
with runtime=30s and ramp_time=5s. The tables below report mean bandwidth; the
detailed per-test rows also include standard deviation.

Note:
- These results are from one eDMA platform and one HDMA platform, so the exact
  deltas should NOT be read as generic numbers for all dw-edma integrations.
- Both endpoint setups used nvmet_pci_epf with a namespace backed by a
  null_blk device.

Summary by group (BW delta %)

              all    read   write    qd32      q1  small 4K  large >=128K
  eDMA      +54.6   +46.5   +66.3   +56.1   +53.5     +82.0         +46.3
  HDMA       +9.0    +5.5   +14.1   +14.9    -0.7     +24.5          +4.3

The eDMA setup shows broad improvement across the test set. On HDMA, the main
gains are in high queue-depth and small-block write cases; low queue-depth cases
are mostly neutral, with some run-to-run noise. For HDMA, watermark interrupts
are needed to obtain a reliable running HDMA_LLP_* progress point. They can be
mostly overhead for low queue-depth workloads where the current descriptor fits
in the LL ring and there is no later descriptor to append.


eDMA:
  - Testbed:
    * Endpoint: RK3588 (Rock 5B)
      controller IP version: v5.60a
      ll_max: 170

  - Summary by group (BW delta %)

    all          n=26 mean= +54.6 median= +38.4 min= +16.3 max=+119.0
    read         n=14 mean= +46.5 median= +37.5 min= +18.7 max=+119.0
    write        n=11 mean= +66.3 median= +68.1 min= +16.3 max=+117.2
    qd32         n=16 mean= +56.1 median= +46.8 min= +18.7 max=+117.2
    q1           n= 9 mean= +53.5 median= +36.8 min= +16.3 max=+119.0
    small 4K     n= 6 mean= +82.0 median= +93.6 min= +18.7 max=+117.2
    large >=128K n=20 mean= +46.3 median= +37.6 min= +16.3 max=+119.0

  - Before mean -> After mean (MiB/s)

    Case                         Before             After              Delta
    ---------------------------  -----------------  -----------------  ------
    Rnd read     4KB q1  1j          22.7 (sd 7.7)     48.3 (sd 11.3)  +112.8%
    Rnd read     4KB q32 1j        206.3 (sd 23.8)    245.0 (sd 21.7)   +18.7%
    Rnd read     4KB q32 4j        213.3 (sd 28.0)    332.7 (sd 45.6)   +55.9%
    Rnd read   128KB q1  1j       512.7 (sd 193.6)   644.0 (sd 152.8)   +25.6%
    Rnd read   128KB q32 1j       2285.7 (sd 15.5)    3071.7 (sd 4.2)   +34.4%
    Rnd read   128KB q32 4j        2392.0 (sd 6.1)    3290.0 (sd 1.0)   +37.5%
    Rnd read   512KB q1  1j         634.3 (sd 7.8)    788.7 (sd 15.2)   +24.3%
    Rnd read   512KB q32 1j        2388.7 (sd 5.5)    3282.0 (sd 2.6)   +37.4%
    Rnd read   512KB q32 4j        2391.7 (sd 5.5)    3293.0 (sd 0.0)   +37.7%
    Rnd write    4KB q1  1j         24.4 (sd 10.2)     42.8 (sd 13.2)   +75.8%
    Rnd write    4KB q32 1j        109.0 (sd 13.0)    230.3 (sd 27.1)  +111.3%
    Rnd write    4KB q32 4j        110.3 (sd 14.4)    239.7 (sd 34.4)  +117.2%
    Rnd write  128KB q1  1j        339.0 (sd 41.1)   498.7 (sd 102.9)   +47.1%
    Rnd write  128KB q32 1j       1027.3 (sd 33.5)   1617.0 (sd 14.8)   +57.4%
    Rnd write  128KB q32 4j        951.3 (sd 72.6)    1599.0 (sd 3.6)   +68.1%
    Seq read   128KB q1  1j       379.7 (sd 120.1)    831.3 (sd 89.9)  +119.0%
    Seq read   128KB q32 1j        2291.7 (sd 6.1)   3091.3 (sd 22.8)   +34.9%
    Seq read   512KB q1  1j        644.7 (sd 34.4)    882.0 (sd 28.5)   +36.8%
    Seq read   512KB q32 1j        2387.7 (sd 5.7)    3284.0 (sd 2.6)   +37.5%
    Seq read     1MB q32 1j        2390.0 (sd 5.3)    3292.3 (sd 2.1)   +37.8%
    Seq write  128KB q1  1j        354.0 (sd 88.4)    438.0 (sd 65.1)   +23.7%
    Seq write  128KB q32 1j        934.3 (sd 46.0)   1620.0 (sd 15.6)   +73.4%
    Seq write  512KB q1  1j        552.7 (sd 14.6)    642.7 (sd 38.1)   +16.3%
    Seq write  512KB q32 1j       1041.0 (sd 39.5)    1621.3 (sd 1.5)   +55.7%
    Seq write    1MB q32 1j        808.3 (sd 22.7)    1479.7 (sd 3.5)   +83.1%
    Rnd rdwr  4K..1MB q8  4j       846.7 (sd 18.8)   1177.7 (sd 23.1)   +39.1%

HDMA:
  - Testbed:
    * Endpoint: SpacemiT K3
      controller IP version: v6.30a
      ll_max: 170

  - Summary by group (BW delta %)

    all          n=26 mean=  +9.0 median=  +6.9 min= -15.2 max= +50.2
    read         n=14 mean=  +5.5 median=  +6.4 min= -15.2 max= +24.0
    write        n=11 mean= +14.1 median=  +9.0 min=  -0.2 max= +50.2
    qd32         n=16 mean= +14.9 median=  +9.1 min=  +5.7 max= +50.2
    q1           n= 9 mean=  -0.7 median=  +0.2 min= -15.2 max=  +5.2
    small 4K     n= 6 mean= +24.5 median= +21.5 min=  -0.2 max= +50.2
    large >=128K n=20 mean=  +4.3 median=  +6.4 min= -15.2 max=  +9.8

  - Before mean -> After mean (MiB/s)

    Case                         Before             After              Delta
    ---------------------------  -----------------  -----------------  ------
    Rnd read     4KB q1  1j          68.5 (sd 5.7)      72.0 (sd 6.8)    +5.1%
    Rnd read     4KB q32 1j        310.7 (sd 38.0)    385.3 (sd 43.6)   +24.0%
    Rnd read     4KB q32 4j        324.0 (sd 45.1)     385.7 (sd 9.5)   +19.0%
    Rnd read   128KB q1  1j        737.7 (sd 63.3)    746.0 (sd 47.1)    +1.1%
    Rnd read   128KB q32 1j       1513.0 (sd 24.0)    1617.0 (sd 2.0)    +6.9%
    Rnd read   128KB q32 4j        1552.7 (sd 7.0)   1641.0 (sd 29.9)    +5.7%
    Rnd read   512KB q1  1j        828.3 (sd 16.9)    815.7 (sd 14.0)    -1.5%
    Rnd read   512KB q32 1j        1550.0 (sd 8.5)   1661.7 (sd 14.3)    +7.2%
    Rnd read   512KB q32 4j       1547.3 (sd 20.4)   1670.0 (sd 27.0)    +7.9%
    Rnd write    4KB q1  1j          67.2 (sd 5.1)      67.1 (sd 5.5)    -0.2%
    Rnd write    4KB q32 1j         207.7 (sd 6.8)     309.7 (sd 3.8)   +49.1%
    Rnd write    4KB q32 4j         208.0 (sd 5.6)     312.3 (sd 4.0)   +50.2%
    Rnd write  128KB q1  1j        545.0 (sd 42.5)    573.3 (sd 45.7)    +5.2%
    Rnd write  128KB q32 1j       1251.3 (sd 16.0)    1363.3 (sd 6.7)    +9.0%
    Rnd write  128KB q32 4j       1251.0 (sd 17.1)    1365.3 (sd 4.9)    +9.1%
    Seq read   128KB q1  1j        803.3 (sd 78.2)   681.0 (sd 110.1)   -15.2%
    Seq read   128KB q32 1j       1513.3 (sd 23.5)    1618.3 (sd 4.0)    +6.9%
    Seq read   512KB q1  1j        846.7 (sd 26.9)    797.7 (sd 73.9)    -5.8%
    Seq read   512KB q32 1j       1522.0 (sd 36.2)    1671.0 (sd 1.7)    +9.8%
    Seq read     1MB q32 1j       1544.0 (sd 21.8)   1636.3 (sd 25.1)    +6.0%
    Seq write  128KB q1  1j        544.3 (sd 13.3)    572.3 (sd 28.4)    +5.1%
    Seq write  128KB q32 1j       1251.3 (sd 15.5)    1364.3 (sd 4.9)    +9.0%
    Seq write  512KB q1  1j        772.7 (sd 23.0)    774.3 (sd 64.1)    +0.2%
    Seq write  512KB q32 1j       1251.3 (sd 17.0)    1365.0 (sd 5.2)    +9.1%
    Seq write    1MB q32 1j       1250.3 (sd 16.5)    1366.0 (sd 5.3)    +9.3%
    Rnd rdwr  4K..1MB q8  4j        875.0 (sd 9.0)     884.3 (sd 4.5)    +1.1%



Best regards,
Koichiro


Frank Li (5):
  dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get current LL
    entry index
  dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
  dmaengine: dw-edma: Make DMA link list work as a circular buffer
  dmaengine: dw-edma: Dynamically append requests while running
  dmaengine: dw-edma: Add trace support

Koichiro Den (12):
  dmaengine: dw-edma: Fix residue burst index in tx_status()
  dmaengine: dw-edma: Fix HDMA channel status register access
  dmaengine: dw-edma: Terminate STOP requests without callbacks
  dmaengine: dw-edma: Clean up vchan descriptors on termination
  dmaengine: dw-edma: Serialize channel state checks
  dmaengine: dw-edma: Add LL interrupt placement policy
  dmaengine: dw-edma: Reclaim issued descriptors from LL progress
  dmaengine: dw-edma: Use HDMA watermarks as progress events
  dmaengine: dw-edma: Clear LL data entries on reset
  dmaengine: dw-edma: Dispatch DONE interrupts by channel request
  dmaengine: dw-edma: Reset LL state after terminate and abort
  dmaengine: dw-edma: Recover stopped HDMA from tx_status

 drivers/dma/dw-edma/Makefile          |   3 +
 drivers/dma/dw-edma/dw-edma-core.c    | 577 +++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-edma-core.h    |  63 ++-
 drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h   | 150 +++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  50 ++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 125 +++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 8 files changed, 847 insertions(+), 126 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h

-- 
2.51.0


