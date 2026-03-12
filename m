Return-Path: <dmaengine+bounces-9398-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GENVHQjwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9398-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD2276113
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18E731DE336
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DE3F8E1A;
	Thu, 12 Mar 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="th/edMhB"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E03932D1;
	Thu, 12 Mar 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334231; cv=fail; b=uH802vM6pvChFwBvFXsoGutOogpzf5GEEgWbZ+3HUr/dOG03+yN3wxEHUW6k7VW7vJnjWKixImxS1dmIcDEQH7Bl9AKN4vM99uj+U1f65ORI9iVbn7ndttXTyAirFG0ErBc9fzBzL6XZJkxGglhj1vapvhtNRG9ATUdyjvxx3SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334231; c=relaxed/simple;
	bh=Wg3yvvSZYgfMREpJR5ThPmU7BTl+fx5Q/wKJexk+3bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C019bL1QgTy4VmH5xgThS0LgINBgXsnv15jsWiu9g2Y6WKWHvBcOddhbQLsXUsyt/SXudIfWujnuQzAlLF2IIIkyydUe6IyLdqeb0rcYp7dPGCcAxKv6franHlxqqUoTxWXkmUAR/taBct9fwpB8KcybRJEaTpFs80HHTsGCKaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=th/edMhB; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otPasD63its6SdPOGhVIYwDaRX5QA9SW/dLprNAotZzHtQcUsAqX0dv7+SgZNQ4YziITEDhevpMwU7LbH45haIkWojGM0XxhT82t93mzNZS/3Vfxf/SdPnSpqc2VXlZEoezcScoi+jeavzx6FUtZabsWNLCfru5lxQRCT45pkEixv4AIVAz0rft/oXsNoJIZqMRVYCPFee5fBNCo9jbiHuJBl3ATaUmpkupvW8pA/nZn/2WRc8pTVVkfNe/im9bjIaowo0UJAoktDTPXAXVOgKvP/flCGiHIFvx7Ryhz37yycgTXl+nJ3K7TkiLqV1G/vlWUIhIAX+hAiMTE3E75Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReHTACPRqYvGvO1QsZIoKLIMWjbE/9lmCYv4bxI+X74=;
 b=PCjxgY52Ug6W72liuxJ/m7zLNgNkaoEngnl83T7Gbf57/2fZ4CEeaFCBUNdihgzmxWwASaaldSsweRj2AD10q7X4TFeGlS8tAFLsxG25+NU4qXJxpkp6ibRaIM0IQ3/O4DcDhSzFRbABmx2z97gH0hUtvwdowolWQ0KRtMrqL5pAVJ0LwGQdo2LjXVC6f0+QUPvByh4LiM/lN2dctxcob4gPvBo2WFLS5dzIq7Yd17oQcjMXf8QT+pV4E5MYfO7bT2xEDvsH12vaj7ppI4cJTuIEmuIMNYbIQWj7uxrh5MljW1b385ewJUart+Z3MgEKCRPIGdNNUqGope5Rl3Syxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReHTACPRqYvGvO1QsZIoKLIMWjbE/9lmCYv4bxI+X74=;
 b=th/edMhBAs3xITQ1uUf9NIOHqYftr2X46L/UaMmidqX3NQSPncRdnCeZAbbEpRtUHBZD4+jm5/X7nylvERanjJvGu82XFSRmiYftfbeNvyLoj9ug1fjXVJgiMQn/hl6AeDxCb36Ip1y4OA08vf+SUv6zKKBC2eSA1/IoK0H+STU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 03/15] PCI: dwc: ep: Report DMA channel metadata for aux resources
Date: Fri, 13 Mar 2026 01:49:53 +0900
Message-ID: <20260312165005.1148676-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: c43f06a2-f14f-4c30-8836-08de80576e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kks4HWpacUgpQ0XrtAnCQk6dbb8EMK+4IgIzGEik17Lsj3aApvMfqfL6pgJ0qOzC6BlhWv424cUm91cCo9Swo+Re8PBwSnt2PQRkOC83s4mX2dNiSD50TnSSvgRCxTq5pFLuBNqdi0lt1FMxLdmpsyQFvMgnhlpdpJB4ICMjVsNB2Yy0huLRPoUquNz/0TtAqSGVw/BYyjhNCdi2d5SUqlvpwpZX+MHPlYiK/ZcaPSExZo7KsM9krwrbRXO0oJ16YKZEBCB7ORL9FZ4oZfPKX83Vp3P0Ktpg4fPaVjHxeAcpVv79Aj843vh0zTwcwX4DYPdoiZqn6UiQfjJbwy8ndxNKr8XYh3iYUBRx3FcGAgCg1IAIdnbdTWK2J0/UQAV1D//r8QHLrFcoPnA7BdD4VAioFBesUcRXdxGGolQi+iqEsbz01EUSAqTxldBblNlvd9padX8MOK8vqt4+mBp83WKoy6DSZ/dV8NHtm/uBxtEkhh/ckrnqn3ec3+L3o5tc9c1HPFnZju6+G9LYAd0yozql9NEpAJYjB5XhL41XrgvGIxlgjrsY2DriKXT6CkR8S79BUHRMArKJMG4uf2NJb2r5G0cDHJunMXnx91B7F6ItJpjiqKPZI1WNG4eE9J5ccCGuewkO8TcfGmCVeYHLXmHfSzWVc6HovY+8OjMOzYMBMYmX62Pyyh7uJyVlt9jAWz1iA9flhNbcTv6bbjnacvePHz+JeOndtcsST5buemUc/qhPYxAwj7tttcaIS8H7JPhYpyz4MRfx69yqDezO2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmw4Sm6vAxP/FynnvJ4qTGOW+foDWpUV6rpnk458Q+gXwuj/tAZR2wBF0jsp?=
 =?us-ascii?Q?8in26BlTEgHVsAi6+n+3zVWtbSPXtV683as6PSrZexEqk+NX+3NWcKGW13UB?=
 =?us-ascii?Q?l465AYIzq6J5oPuAydsS5ZPxZLFJnx7qkjOcGKQEFy3/oE70vViT9+QrX9OR?=
 =?us-ascii?Q?rF6JgvQlnBY/7/Rk6cmEE+wbC8DYs0nClHREKlkzFkmzRf0jOVDbfkgSq6Js?=
 =?us-ascii?Q?h3FjZq8URpLQ+2cQGO9mqDzVBRujZpZFw1j29DRbtlXtTPA8sVVSqoC8wl3x?=
 =?us-ascii?Q?yZVkeHaBYiRfCurGMd3Zd4dnYVO24nSW7e58GROlXMFp1FXxgP+/oSbQGJju?=
 =?us-ascii?Q?Z+SRPuILhx6uNkAXVBrH5IWX87xjjwYtsKTPHo41CcSygdHrxEDhhP3ky9HT?=
 =?us-ascii?Q?voC5ItminU8bhXYK9qAEB0xGZPwAlpjzzcpB9uNqGzBeAMOrFqbUrkzZtgCk?=
 =?us-ascii?Q?u56eapSGMcxwgbicwkSfExQ5lGBFaOEHLujBmhaEjvT0iHOa+yoOod6b4ode?=
 =?us-ascii?Q?vLgm9ZZ/COIsDEwAjjP7Fi3H665BQ+WVnKiLkZ54AK6thHDBSC9xOLYhPNu6?=
 =?us-ascii?Q?P24leesVroIiQLhgRMShDPDqEXRLN6Y7PuUcIvX84siRJRzb4qmZI/R3fCWu?=
 =?us-ascii?Q?3DdK/i6NftQ57SvNWTe0tuNrYJnxDjbcD/240Px8Mnh/cFklY0s0srOA90RF?=
 =?us-ascii?Q?/ZA133txAPQ1NtzZjoWQqJf4FRj6iLZTY5NP6OeG4w1yc58wrqt9jPjK0Fwd?=
 =?us-ascii?Q?TW3PRBPj5BJ1GOBsyDtR1RxSY5niyIMgZCiE34ONpY5A/pyEJoarh4xhWc9N?=
 =?us-ascii?Q?Ww6xJ/XKWTOl1lh+eCS2iD/EFuY8o/a7xWPGG1rwAPQ4hIfRauAh7Q3YkLqS?=
 =?us-ascii?Q?8grmxHDJgp7TUAp9qrK3xTPZKG2Vu0kyjZ8/rnni8sSfdC2LbbSKb+mTp/Zg?=
 =?us-ascii?Q?bHCgvU5tfFQxYt8ph9FcbGLkWrRd2gtHJ5pJKH4F6Vrq7e23Wl/Z2PcvF/bm?=
 =?us-ascii?Q?ssAC0RDNU6IWzRpujt0iruBWVy87aSuvMwGvhIsXBCYQCgBJdpI6D8mFf7x5?=
 =?us-ascii?Q?5b7S/+uwzrUUXf1fWB44Z0hCU5RjBROGJTISj0FYln/YOCvmLRgRCUtUfk1p?=
 =?us-ascii?Q?1Ya06vg/aGrzTpTNYqWAS/EEsFwuxbOX8CrcnktmSebs9mrxV/YLol3uCfkM?=
 =?us-ascii?Q?Wulz+GIPf5siF2chQq/5S2R/a9xOqTRHKPANY60dlGph30zCLs0E6FUa7SCa?=
 =?us-ascii?Q?tW20zkkDVT+btZzVsDfzcAMru9RZ0R+pN8VZQG2kN3uU4mq5DsPK/hDEbuL1?=
 =?us-ascii?Q?W8D9njWQEnV+sYhNXTHWJ1wNi7hgp2YN4/ZI+1ShtViL+XIOhTZfXpVlpiy5?=
 =?us-ascii?Q?0/O/mHyBiPFXqyP7YkUhuprr9hrMUoFe36X7EfYFU1iXuvxHV1wlKRKFaONH?=
 =?us-ascii?Q?ftEFiTGVWeuDAr4WK8NClX+ED8kb4zYATnairGOaZtSZo7ukKGfKe3XjPM88?=
 =?us-ascii?Q?cB3qjativ46n7wHlCmKGw1C1QpsrugVfuoJf1NE94xO6ZgZv7CxrXeZ2PT5h?=
 =?us-ascii?Q?F16+1AmvGmyxPrp787SPVODQiFrK7o391laeinwbZnxN6wx/MyCnmRFip5jl?=
 =?us-ascii?Q?Uq3qNTpgFMbNC07szxWxEd2A/MlOaQcXZNc/XbkfuCaVSClVWf0S8FpqHrhT?=
 =?us-ascii?Q?BZEeQizU6gN9JmxDBI0jsYJTn9kJKuFHMli6Zdnz/I8pDYiYuDHJ2MQKQtss?=
 =?us-ascii?Q?hNtLLkBkx2Wuz+ynRpZLtlyx0LUIZTQGwfTNlj0CnEGXtExEorn7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c43f06a2-f14f-4c30-8836-08de80576e4c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:13.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKTWeDEPSmy1oqlzC0+lIrdC6O7EZkFI4toqu+kTH45Oq6LQjwyVxtz6XdJZsGB6+p9wwaAYpTs032JihZy9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9398-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 15AD2276113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DesignWare endpoint controllers already expose the controller MMIO
region and the per-channel linked-list descriptor windows as auxiliary
resources. Populate the new DMA channel metadata for each
PCI_EPC_AUX_DMA_CHAN_DESC entry using the cached channel IDs and channel
direction.

This lets generic consumers match delegated DMA channels to the
descriptor windows they need to program.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index eec20800a745..1e584f6a6565 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -947,6 +947,10 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			.size = edma->ll_region_wr[i].sz,
 			.bar = NO_BAR,
 			.bar_offset = 0,
+			.u.dma_chan = {
+				.chan_id = edma->chan_ids_wr[i],
+				.dir = PCI_EPC_AUX_DMA_DIR_WRITE,
+			},
 		};
 	}
 
@@ -961,6 +965,10 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			.size = edma->ll_region_rd[i].sz,
 			.bar = NO_BAR,
 			.bar_offset = 0,
+			.u.dma_chan = {
+				.chan_id = edma->chan_ids_rd[i],
+				.dir = PCI_EPC_AUX_DMA_DIR_READ,
+			},
 		};
 	}
 
-- 
2.51.0


