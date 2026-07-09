Return-Path: <dmaengine+bounces-12193-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G+fgC9OtT2qJmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12193-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:18:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE817321E7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=dxUH2Jcu;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12193-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12193-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41F9B31055E3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12056431E46;
	Thu,  9 Jul 2026 13:59:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAD423A9B;
	Thu,  9 Jul 2026 13:59:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605579; cv=fail; b=MgG4Upf9ukaqXFKgccuZYqshH7+LUQYXsVOTVqFWxXzil7O5sjF4qZGDx/CETJxQn68uL2fVH3DdtQw7VchrwZOd1mGTascW19a9Hkic/QOvIhoHgsoMNciXZvjUsE62WpI5uyYBzzfQ6wYQCdV145CHN70JhT8yStO9KO6nVTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605579; c=relaxed/simple;
	bh=vBmAb1+wevz3gVV5VxYqld8jPDCApAIh2olKYU8un6s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V4OFLfZIqxv9R+Co6ZUx+QUPM/BFBiwbhVqKP+JGKVcYEd1eSC/D9RIVY87nuhW+06dt63Ah9gJU/9o6FMTJFs0ZLRIffJWAhAzEjESxvL7NcHXAsh22KnsBduOoi2bv97znZ/0WscKA4B5fnd8by3LZR2PxvI8gGM6RRmjUZko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dxUH2Jcu; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR0ih2G6vbwhhEAXVRw/XsPeul46tIcy+s+d4sT0af8X4eGcpPesiO8oTWQH/s0tqfLfYF0WSlB0FEK5t64JRlJDd30EBVA0gMpkZA1A1aISLkfx7u84S4dcVC7wyU6u+ZDENkaxCPFob0xgIOZHZ4nTL3d9dGj8PX6O0QqQA/BCbbWD424xiLqKYcRhKYT8XjfeMVZ317Lz2+xQiXeiVuDYJWPrAQRLFj0rfasuzG9XIX0EYHNht6V65XtjsV4bmmvtjgRix9jVxk+42YiJe08nMHj3/M1H05psr7CMPisdNiuWpf7T8MJxiMP1u/2a/so3/LNEgPGUOL+d8PjSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66rNvygRfufrhI78OLYHang72jL/9SCL7mgnw184jf4=;
 b=TNlfVqE0zQYqBe8VNxzv+wmZiJQyLuLKVhiwKsyK76kK5yQXKlOBLFPvV/gvC+13N7tLr5aG8YRcbTzZgx8I6N1+ZRKXtA+aytO12ukaoogzEsTdezGeNjf2o+IL99NhqujsM9pgLvR/L1mn5yWW0JbfZcN0YLZDt2UHoY8tppODuv5cG8oNRzsaJakpXx3OUGzw3Fr7QtRYFRndBY+VzxYIjF0K0kL97kIcU76zQa5WRbtcMFutkPaSbSvvYHeEHtfnWsSkfuPMSRnxCnotpp9LBDrZH3mg36hXCKvSyzW+FOuTNAWnwES84xx5kbAf80FjpNt9gxkujVM8tSn2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66rNvygRfufrhI78OLYHang72jL/9SCL7mgnw184jf4=;
 b=dxUH2JcuVlCzb8kSfPKm703rGK2YR4WCdEEFG4G9ZdvZcmtQqjCTNlIcrJjwEQCx8/CsC7gn91cKtTn8JSfO3cpQFQ8IC0q6XRMkUN+MxNtTcXzlV8JZsi59vVtHzCMqbS3+mUhWUZY8vxXSGCyfFVaYM3/G6b6cxx/xbaNKnBuhjUVVhBT4WvGJGYWyEZkX6hrT0VvOZ5C0bmUF6jBB9GGbzGbii58nBBYKYkxgLm/edIhepLUn2Xws8EoiA6BdhK4FHhKYYk3j/9XP4AmJfqUcSaxqAarf2HTfxOxLOdIvYjEKs+kN8GYz8X7QpmYqfONGNBBOzOLi1JTIfcun/w==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:36 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:36 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kees Cook <kees@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 15/26] dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:19 +0800
Message-Id: <20260709135846.97972-16-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: a0740631-48ec-42c8-673e-08deddc24f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	V9nft691ubfLy64wsw8fYektFuag9vKu2c60OYDLrUi9F4QynmvPWIA+qhKUDlabWS7ZR8CyMG/BzhVPq8Q89mPPF2SIxCwphKit80DK2bYN9Z4sDB9kbZKZ8QvSUmSUJu6p+YEk7vFw2XKXp3tRRHQlg+tjuxfEbCY4Jc1oWgEc3GV68dotOM2QEuP6gvKiHCxSAf5bBCKqoPCGa2cOwq2vXJ9wn/tqldZ8gFNQ0I9oXNvXeeFn5GKCRDllcs24R/D35FQbEBiXcIWqIgn1xCFBBvJAIIGU7xpJfNDHk2EjBg440OfR2sZ7H3qefc55s+XdSikU5lJmYWT/shLF3xenRMQUqDrUeG/RL6f8UrhH4Xb7IjlCnN6+4c8cmv3ahRZPEpKx6E6lazFMgbRN9JT2G3zj784weARjbilWwVbyLKHGjWQt2nRwiTVGsBKVsEV/bXpZbxg+VddB52fPwqOF1KNncn7zCuNwU1H3N0V2a5Go2Po8uJTT+8t/mjQHc0cCQ5nZxcb2CxS51oHoO5N4w+WaWiL0tLIoLP3P9xI/iO4TKXA8Qe/MRUwLiOp0jFl/p8LOcnkdeEJTkN7HkRLCGFOFEVyeVD8iVNVKdo6qYbNBUPPEF2MItqf7JqXLNo/02mgXp+QfLbQl3lB0FCk21YChpWBlDJmMMKv+g/6PhPDlF0ahY+cF8Cw9c/JU5I1Q6jKfJkOlVvB0heffo7sNkBm2vDN6h8WkwwvN4J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fR4VncUMyOIVZh1M6mRXYc+sRwanbRQgmeZGo55P9Syoy77smZ1DvzavaMl?=
 =?us-ascii?Q?IdErZAWtWkT8y5U9XH84gThZ5EYiiMy8F9h2a3Uz3nSt7Kqadeyx/OQEO2nd?=
 =?us-ascii?Q?aUfaT6V5oEnpyisUoakrD71wQQ/tsbMnHu3Mnqf+XWFBV9KIXqZGPrmJ1y8x?=
 =?us-ascii?Q?Iv8XhYicwSPHu9eap5CRy3SUa2eQnInJirMOtqZWC/Q/CvzphL46HoLyYViQ?=
 =?us-ascii?Q?8aLL6Y5VMrIARYKXmfJ6cg1S/1lo6AWUALbXzUQBjmVM2aClZUeqFqjb6UOQ?=
 =?us-ascii?Q?PXyzilZj7sxh3asBeuYQKBSrEF476dM4F1AZLKuR3tqr+ii7WeVuGCqNp0yM?=
 =?us-ascii?Q?2qd94jClwQv5rn68eRPE3S+/RE1YI1x/V10v0nD7T7YEFNlP4aIaIEVMCINF?=
 =?us-ascii?Q?siN1v5tBERN/CVvn572ufAgAOt7dcxp2BlSs9/MhxVmMsjASgdt54gzm9+gb?=
 =?us-ascii?Q?qXGys66eZ4h8HMyW+t/nqmtZrzUtINEHJwhj4g2vJiQbDOjndqPgdYT53zfv?=
 =?us-ascii?Q?/ZEpPboS3NU+xPhHforW6UrT8RzdN3d5JQjl30M2/mtR20XcBI/ngkDuSlw+?=
 =?us-ascii?Q?t1+tvYavmcs6HJmkuPHttKhBfRF5pRfWVa6cheq2S7YUUDN0XtlnUmKM9kvr?=
 =?us-ascii?Q?wsfU9LvXwghMDKE0hss2hlxKDIwlIE0r1Od0EBAWjrCmtfRxfAWzW8YLz9Lw?=
 =?us-ascii?Q?wvPOGPeTLEETiMrbGaHmeq4nlyw+/4DGWCF87TsoYVYnRlEXCZnEzMbsNCqY?=
 =?us-ascii?Q?WXb9bb283cYPOLhahnFnQJ716J7/Av3nVi3U72eZmeVjl3OJaRRhClZhg83l?=
 =?us-ascii?Q?/r8oHNa79AoIVk1Vj68KA1ktDmZdhyaAuXgxVaw+qAcgmOZvueKKlV1eLAnX?=
 =?us-ascii?Q?mPNOaLzjCwb8uZuzYqrBS6IBB+tEU5VoKK5uWXnAcMB25eWkwbxKPOfAzGNq?=
 =?us-ascii?Q?HiyTrfGprJhDViccJYEUaSrB13M1nnXw50d0MQeCF1Kq9vD8mYyrsjxeZT2s?=
 =?us-ascii?Q?PYEb/6RU1RrFuj3YR4aaKpux4Ftfm2awkrN6eD8v8/5anNp2uLkU/QE6BAmc?=
 =?us-ascii?Q?stszjc1CbTM97KRM1Zumdv9AIrPVmXKOMQKcKU/btjkhZ7z1/QSXWUKuZN82?=
 =?us-ascii?Q?e0//91PhOkh+vwzxPdT53CcIpcn5niYmcQupwx8gFpVl1FE1byvQqVZN/2BH?=
 =?us-ascii?Q?lpwRz1ZKR5x2NURYUSzY+jNrC58r1g6CsNHZ9KIcaxwS3qTNEtDsbn5+RIcX?=
 =?us-ascii?Q?pL3aArh8gtge1mJlmZWV51KjYi607UcsE5npT+3OuWnSJoiSW6BKD/9HJeeU?=
 =?us-ascii?Q?Yyjw+oaqkiwgtxK+JIobspSVq9SJpqEYa4mR2mgZNgMSFV6Snhq9vQRGYAoz?=
 =?us-ascii?Q?cQajXAm8gQZsI1/cUWi2WgjkL1IxyjtRgLVH4rzvm94YeHHBIKp9B3uJi30h?=
 =?us-ascii?Q?/CtcWWYAxdzkOqHHbpYiBKYRiwn4kY+4kv8RbtvaOCqMy48wVugZzPIaKf/Z?=
 =?us-ascii?Q?pUaGd4kCgowk5ckwrOMlFasZNCBkhon6JXm5J0d5eTZJqrmKZUbt+fgagNIp?=
 =?us-ascii?Q?0XR5ZoaYFWfmaacG/wbL/rsMzBSG84HPfP91DJZ9rmXMOLmaT2jB9QMMIrzy?=
 =?us-ascii?Q?niO1NI27wCFmXT0IQStUrVPL738IO5+1KbvlhqDlt6EAy33rpziuxlD49ArQ?=
 =?us-ascii?Q?X+sbEFIIRrCuYD/ZhjdoQfO0ZRGMWBoG+P0fQhY3KF4jzFZuyKgqecQlUM+B?=
 =?us-ascii?Q?iKxc7buC/w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0740631-48ec-42c8-673e-08deddc24f89
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:36.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bndNDv0DxiiYYuvP4AQBDkEE+dKvdR3/AlbTor51dq42/eti/NarpWE2YDR757YmxOQwJsvyO3sUDy3psTmnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12193-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:panchuang@vivo.com,m:geert+renesas@glider.be,m:kees@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEE817321E7

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sh/usb-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 16509be0d360..17b385d85793 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -726,11 +726,8 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 
 	ret = devm_request_irq(dmac->dev, uchan->irq, usb_dmac_isr_channel,
 			       IRQF_SHARED, irqname, uchan);
-	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			uchan->irq, ret);
+	if (ret)
 		return ret;
-	}
 
 	uchan->vc.desc_free = usb_dmac_virt_desc_free;
 	vchan_init(&uchan->vc, &dmac->engine);
-- 
2.34.1


