Return-Path: <dmaengine+bounces-7784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E313CC8744
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9EF3011A51
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614338E163;
	Wed, 17 Dec 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wmUVyP8/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700C2E8DEB;
	Wed, 17 Dec 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985541; cv=fail; b=FbZg6JVJ9GEA+gjxrFrkbHQOKK7ej6zq2WLfm5FdY0VDNq+7j3TC0v+U7DElQzXyNDo6GoO+DNMUYWSuR1by9HlFZxVVcVF90XqcdZ3HlWNzWMtICkLy3ried1tMLEai9z8B/ljW0O+DZaXE7vXrSDmbrLctXxvyAZ9BjtTEfuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985541; c=relaxed/simple;
	bh=Z94kacvGVOkNr90TrKaU4Qw6wmAMooVjTDD1BRnhZw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grMiIjiZth4os2M1TC4Scf62R35ZuP5A15DdiJgCmiBIn70LN7+cqt3W92kL+Xh06qSVspVWkWYd23WOPoqQgoqtpkPYMh3qaNM2fI/xc2oz9URvK4reG6EfFJWoc+/bi4UXFdzaEBD9sXytUKyiZMsKW6ome1YU18psdFNdsbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wmUVyP8/; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwhU1zOSwK257Nt/yPZ0lHjHQJqbOjbs2D4PS4qG1TR6TZobgUY6Fhaewczg3gcbBHMfDpRqlyEP4Fk+jNc19VNLKeGZ1x0/CVPdKD644FL9V/SZSq04amKA/JZkxeTkjTTlL+uB3Qydbi1bLMT7dmWsT58AFwdBCfc8a7jRAC4ZsP4vaDg64lO3fTRcQ3TmIZ6DHygcDgSMSUD2Z8uBfg5SBwe+8z08WYzhkQKrphIxA85Ahdn4eg21fTLXRrhughAC7uIGnygrCErfV3aUwjyGTbVSZzrGdUau9NbTNnxzkJKZuzTJPfIqlK847iTbCsdLDP2jSYkMQ5zP6+iUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeyvcBNQwhyXrcRh1XFkM7HJxYjuKadsY6Uw9FGvpZw=;
 b=n2SgWPfBzWx0XCOosTkyui04Rp2IGWlu/CN96kGx8IEaRjrDk1/IPLCpT99nfNvZXVyEjkpewdJy8usz8f4/wDkPGrETLLQxpWSlvqsSz21ilp7MQsJoKKaabH6rwHmAGBQiXPPKGHNtv7i79BIEe04y/KL2prNtNjq2iU+Sb5Sdi41UHiEljXDl25BD3/P99dzsMvInOG349IKmWHf4pVBq9ZPw3Ry6w4HYT0+8gUzaYfbPSmIdZDD4btvJ1dr+niXgRZ6Nevq1pk1v+kLlEYPMDXoI6n7U8OW7XezGerBVLwnRhnN5njlAjQA4b+B1ebhT6IQApL03xLFMRdAuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeyvcBNQwhyXrcRh1XFkM7HJxYjuKadsY6Uw9FGvpZw=;
 b=wmUVyP8/UQDmqij8rO8PC6UISNPevMaUTf7f3JKuC7QrYGexJoKsfl78ur2yFfOe5ZYtLBpo7s4RNRRh6n96fU8Q56+5z5nZjeZDx9H1QweUnc2v7LwgurpuBGLH/jpaSoyDFQWv4BE2UHcqBcSx4cTtrwO2x5Qnv1nVkN641Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:25 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 13/35] NTB: ntb_transport: Introduce get_dma_dev() helper
Date: Thu, 18 Dec 2025 00:15:47 +0900
Message-ID: <20251217151609.3162665-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: a8519720-7ca6-4040-254b-08de3d7f3e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kTJGk1HOvD4Y6oLB6NyOo5c7osvDCs9/S3ZaoX9RtqyZKVIVn8YbHZzMDqc?=
 =?us-ascii?Q?3Pks0pUB5p2MJWlaRK0NKTOTo2TRPWST5f3OTw7utLlmYNzPax53ujEXs00M?=
 =?us-ascii?Q?WYwOWeaDqTMl3zozqMZdcmsgz23K+rcMlxYfN1YwVum+GrBt5d/lperY6UTS?=
 =?us-ascii?Q?5WGcPJfrUZJZQfsVLbPrjB1r8j0UD1UdSSdTdx5Bx4PgczZjS3w9dkRzsqKv?=
 =?us-ascii?Q?p+MkKSoEThtHil35L8JzeG4b1RroWKEuzxTJDvj3iQR/YimeTUuNSSuw/Ko7?=
 =?us-ascii?Q?XWDtuTRY9mcd5xAB+GP0O4gbZxUPjti7bzPpGdMNteKRM++COfH4iLB+Y51b?=
 =?us-ascii?Q?Ri3DKbpn3DLnSxNvasljl8HYe1AIbWPAf/YPYDMZArxDhHI77jAnYQDA8mcz?=
 =?us-ascii?Q?53V55Eml2n01F4Xrq47kWrXbE2zZtEcHfmA0oUdpn8w+7cy5yJpRBunRbvpR?=
 =?us-ascii?Q?doI8DiPW1vCCBZqPmB2H3CLmje6AFRvAcw/Xxhl5r/u8yzWM1AK8310h91s2?=
 =?us-ascii?Q?ad6LmONOxHKIPo73NZpFV1QbXMYs798UtMIApgEOTxZ0sqh2RKn2b1UPGsHu?=
 =?us-ascii?Q?LrQGmiCeAo8apQwoXMOafXjQ1ZxhMeLuWJBLym20UOYXyEsIQdoldORAZI+W?=
 =?us-ascii?Q?WGuu6HYo0yjKpR9oHroHhxK/V/NtCmOdBnRIUWcYsHxpk/POfVhKs+nC9Waw?=
 =?us-ascii?Q?94nEPEvKzhisl2Wa+k1DCcNRSs0MeW/m6SCrg/4O/tHDINeAbofV62NMuiRT?=
 =?us-ascii?Q?hcfNZQ2ktNL+/nOXyPwFQhxJtNdXcXgykgKzD01ZA8Dgk5gw2emC3aOI33Ja?=
 =?us-ascii?Q?hpfmHTVBD/sq/eRnKDwGX7wrUN+UWczWvmpvTzABin/RJQUL7X5rxoMTVJDN?=
 =?us-ascii?Q?evSX5ls6QhzsPKaUKUJTLuDN/NtSXcGUNVBN2GMfaOUoieIon/LJcD8cftyq?=
 =?us-ascii?Q?UQpJLTi6k29XgBtajta7ct73SyWi78ZCU7JoljUdGBjjlCYCtTzV8ssKruRJ?=
 =?us-ascii?Q?wNCfeNL+rx9o5U5SaEhQnIqwBCSqBqrm/GRRAs5KEuuiFkQBRGnKoeDpog8M?=
 =?us-ascii?Q?kdUlaXlKc3XyAPq7yLw95ejiXnKgNFqVxSUwz556I2o5vWQGpdCE+gDpxVaz?=
 =?us-ascii?Q?OghkdguMYlP7vYWLNqld6mHW0NzvROXY5XuGc+flVTtoPqKCQVwv56tIfHyd?=
 =?us-ascii?Q?IQ3bUswOYxl50g+ue6ForJ/l0NEpkFC+xov7K2Z4nD0yMZPw+eNS9FGP48H0?=
 =?us-ascii?Q?yBxGaF5J1fhbCESE08iZCnKosS6Kw0S8yr96kUPfwbapUwV4xugeV2MYM1+L?=
 =?us-ascii?Q?Zkbpfyw6HqL63IBxtIt+GSlKNqEi3+0LyEsK32FA5pLOFWLcZ9qLVe4QCqVe?=
 =?us-ascii?Q?W7tuU9v9we5jw7iE+AUcC1AHjndfqdklC27sSVbktjTpbavZ3QhVXMg3x+7/?=
 =?us-ascii?Q?/AtMcLY9cMsWo2r+sQnGw1IvEOaPaQCB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7kJ27VMKmVISnwYA27tOxpP+PFIbTZaVmZ8/kXs8BlXQvdOGeeohnVkmFiH?=
 =?us-ascii?Q?HWGkjXyxItvCk9X1NNu9fXtHR/P7bc9I+eFvvn4ODKDfjWbYb8SOeeOkBn0A?=
 =?us-ascii?Q?rV5m/i7lGEqylRSX8+w+bM2Fq/iSd61oc6rRwqtDZRGbiMwbgItj9h4CR4qg?=
 =?us-ascii?Q?7iG1Jl3d9rkrlzR8gUNE+buEnrkx4k81n90uPJVj5fmJyUm8NVoiPKcmJSDP?=
 =?us-ascii?Q?BgZR0b0Rjh7S8UnH7+qKtL2u/qio49+l4atc0S1HCQ//bPd87Op2Y5Ll9O5r?=
 =?us-ascii?Q?jPm9pmpYGbOTdka621MW2FLTXjli6xIMGczKvm+ByBsRUx+64S/1CYyVpMHh?=
 =?us-ascii?Q?o0HkngT+M+SErooTEWv3Xu4j1r1NCTX5IytubwbV8oaLEAfSkWSaVU1l/Qxo?=
 =?us-ascii?Q?aHKaPiJYACIXXzVI7SqFomZIedI7l4JQA5p+dGURHi0xQ/G7Z/pNNVAui14l?=
 =?us-ascii?Q?jTqDkrJJsk0ARezC0FUSdoCU+cqLRK2ld8Yvn899/I/cb1lVt9pAXIJVU8sM?=
 =?us-ascii?Q?Ad46Kf28goes/syySJCFcRnnQ8r0gB8YONFWmhzb5oqDiPN2L5FiMk5HmtHj?=
 =?us-ascii?Q?abvBkB1ad4k+3hA7TgAO/PSFbxhD3DIgszqibjaGNfTza4ewkwgS/pdtmTWb?=
 =?us-ascii?Q?UYISzK4DDPllsegM3p11h5xFMHqUtK2Eo0Ic/qxZDcNSWHFuppQunzDC4BsW?=
 =?us-ascii?Q?gNyuf3Q62usYl/j8sJ4JK74CNhYdktx3nUozSjR1yxt6+Fog0yklm9AC2G0F?=
 =?us-ascii?Q?bBok5ZrUSx2xvDzir6i7ld2mL/eSzdoYPKOS3xLkC7s6qdZluPtu9lxqF4Yz?=
 =?us-ascii?Q?DzfJcEsTzBApI0v7Jv+E93ThEolJNR+wJUGY1FARxbPvnp5HCCddLVmIropK?=
 =?us-ascii?Q?2ctsdmdC6IKbaNHo0xmFxdVHZS51z89L2YSi97rHx/Ujpw19I5uc8z5gXLQM?=
 =?us-ascii?Q?VaOCWukGz4TP+OyqXs0NhLziACQ/0yufFhOWpWCy7jCxx9yqVponcyYsRG93?=
 =?us-ascii?Q?gJdCzqLeAo0MrMa9SOWOtoSOSyTK3WUApjKi3xtlAggLNHdO0CpGDimmyjf2?=
 =?us-ascii?Q?Le7klhtxLw9pIDWsMX7onMSb4RhHXSMHByla2STkbbf1WMsTbJcRsloAixSG?=
 =?us-ascii?Q?03e95d2XR4+z/wCekl/u5IV+UbKdQLjS+UcrH3Hit/xxn9HAiesWZf7JPjAn?=
 =?us-ascii?Q?wpQ2p6Pft5+Vrim70eB8HIODb7JDep375O7tpmmB/7M1lemvOoZF/OO/gl5a?=
 =?us-ascii?Q?SHGfZyZfDsPjUEao+l2LHoQz8zdmoQLqUMr+4LdxK2wvzVImV01CjMU/WrVw?=
 =?us-ascii?Q?pMlknGc7RQZfaaYT9lzoOvOaIHSRxn8IOSY8GdIBtBVqFnoBBtO7jaEvVQaX?=
 =?us-ascii?Q?lu0K3H9AOgs5SVVrYrG3VHQpXHvtkkdJkASv/4eSvjanAIQWBYU0IfQ6SdtE?=
 =?us-ascii?Q?/ssn92/yJxhUgKkTAQGhfcEwgj+uKUvqG/PkhtDnhsXIhlkUxAXPM/6Y9gDL?=
 =?us-ascii?Q?o7Ifiq7+ZIy7cRvN76r1n1WB3j5qU5568y8ggql6elmFA8rKhxiZzsrx6EOG?=
 =?us-ascii?Q?jlTDVtaeYYeeEkzzeBdLR/LufcbLRqCALK4iOHMEVfbOOFzsRQOEsuFLeAvI?=
 =?us-ascii?Q?CSHWKp/DYnsDAS6i83BeHiA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a8519720-7ca6-4040-254b-08de3d7f3e59
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:25.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkaOkSGD8V1l6bad+MJ7ysX/coaQV9V/QlrBIMtLDkramwJ77TFFP/KE6dqz9m40IbkkBScbbcuZQ0aIHt2saA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

When ntb_transport is used on top of an endpoint function (EPF) NTB
implementation, DMA mappings should be associated with the underlying
PCIe controller device rather than the virtual NTB PCI function. This
matters for IOMMU configuration and DMA mask validation.

Add a small helper, get_dma_dev(), that returns the appropriate struct
device for DMA mapping, i.e. &pdev->dev for a regular NTB host bridge
and the EPC parent device for EPF-based NTB endpoints. Use it in the
places where we set up DMA mappings or log DMA-related errors.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index bac842177b55..78d0469edbcc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -63,6 +63,7 @@
 #include <linux/mutex.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
+#include <linux/pci-epc.h>
 
 #define NTB_TRANSPORT_VERSION	4
 #define NTB_TRANSPORT_VER	"4"
@@ -259,6 +260,26 @@ struct ntb_payload_header {
 	unsigned int flags;
 };
 
+/*
+ * Return the device that should be used for DMA mapping.
+ *
+ * On RC, this is simply &pdev->dev.
+ * On EPF-backed NTB endpoints, use the EPC parent device so that
+ * DMA capabilities and IOMMU configuration are taken from the
+ * controller rather than the virtual NTB PCI function.
+ */
+static struct device *get_dma_dev(struct ntb_dev *ndev)
+{
+	struct device *dev = &ndev->pdev->dev;
+	struct pci_epc *epc;
+
+	epc = (struct pci_epc *)ntb_get_private_data(ndev);
+	if (epc)
+		dev = epc->dev.parent;
+
+	return dev;
+}
+
 enum {
 	VERSION = 0,
 	QP_LINKS,
@@ -771,13 +792,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = get_dma_dev(nt->ndev);
 
 	if (!mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -847,7 +868,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
@@ -877,12 +898,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -895,7 +916,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size, offset);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.51.0


