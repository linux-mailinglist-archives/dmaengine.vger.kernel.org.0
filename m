Return-Path: <dmaengine+bounces-8008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C04CF24AC
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 08:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD4630109B1
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA142BEFF5;
	Mon,  5 Jan 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cj6O+Inv"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020103.outbound.protection.outlook.com [52.101.228.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FC1F63CD;
	Mon,  5 Jan 2026 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599958; cv=fail; b=EDNo+yIb0PUFZeBV2KBK2RvmuDOH5utWcoEsEx9VVqlH0EX1Ip6w7rgs948Ufw0ArazYma/vlJq2OO8yXasawuyLJkhD4lEfcgTyWaR5ah2hK5PqdJJfdgNuct3EpmUeLF75WZipVqPNcJC2FXHfXSeSfHJ+Dpn+GbZQXH31WCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599958; c=relaxed/simple;
	bh=F74BQHIBlSTp00B603vvlaChzttnzzAGOvCOpYtWs94=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dIDsVakFVQT86va0RBJKrDj98IBPzPQlUdcemXxgAuz1WAoYpN+M4utyW9MmN0A94x3bmE5uBdxg4Upwc9h5in19hGjaWn5HPrEQUq155sG0OBMzoDwpnEYQqRYdcgOUaqpnADuJx6SQNwmzJju1ybUQwUJy/0OPQulJIqBnYjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cj6O+Inv; arc=fail smtp.client-ip=52.101.228.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAV82jO3+SaMxgVWiQgP75EBZ43wgO5sfNG02UQo/ik2SbFl9iMGRimB1FNp7WSProOunxy60W+RJY/UECoqvo7ZnZrBVygfUaNKuH93Vkbo1sLa0w5biOAbPO1EivVnKQvk76Ag2CscrfC6Z95vgGqmogY7w3YQwUfmIHLVf8DxSf0NskByfQpuI+8IInte9JKMdyotJt4+dXpdlxrUncs/wD40/3rcc0ZMpH/Dxjr8O2/1bHh5F24SboNWc/brNxaLYwvjUjkrtKZnR2+iW1paJCQr48Ml3nu3nKrSYqhKCA59ndFAkMaBTIRBJUla1Trgam0lJU24FAJvZHKXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne77bEBDSXYt42JRrkLQVdbNvl+iBTg8atgd68vUbXA=;
 b=HruQuVG5XMN2kZ/ODkNUdnkYZLSYn1ioR/3Sqr+jf1X2KBV9Oc2bxT9MVvb0KquYXSv4Jep/0HAdXZu2COqg1NCZtVqW1WrGHpTTJhYZR89HG7yZhnOK/NJv2vml7G7a/vccFm+2A5C+5bP4hyBjxg3dKrmg7+zLnkwHsnE2Ikc6QOe6cv4e3rxMynHyEk0PXr1ghDRXh4z14006xwjhxsZQmnLzi1lnLUK1/27+4Q1qYNzmkxsSytFINIkSl0Ncd0wg7Xl6GG/tmVIe9O0sd/M5Dp5E/LKS0wIBus0byJCmJgvVAZTqymQ4A058WAd/Di2hLsYjLzF6zKY5LaQwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne77bEBDSXYt42JRrkLQVdbNvl+iBTg8atgd68vUbXA=;
 b=cj6O+Inv3xe5+sLtHmMLDf2CzphaOizPr3LpVLVVnQAdXGmZ+hzD8qhVh1CTU+QTGqxV/HKOYExMwUg7QTXtEQ47a8CcfITotE00rBZdVAr4hZKbZM7JYdtcHCqodnBvU1WcRxE0NKEloi6VKwWx8oYpdrgy7CChACX5pjCxKBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYVP286MB3165.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:59:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:59:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
Date: Mon,  5 Jan 2026 16:59:04 +0900
Message-ID: <20260105075904.1254012-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYVP286MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5d24d0-bfd2-4e35-fc69-08de4c305040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ad9Efk3GW0n+F2sJxDYJZX1ir7VF/L0zEi0L6XVuf43f0KH/6c/cWHkyxdsj?=
 =?us-ascii?Q?blZB9n02krTt34OGryFVzH1GBqEh4i9Tl/2I5FCuH0kJvQ6RO4YwxjZpxg/2?=
 =?us-ascii?Q?i8stFk68WXfUg+VeupJk/xfhGjfslbKUU/dHiWiS8O/sJYAZkBgOuT0zNfqK?=
 =?us-ascii?Q?oE6b+/FAbo+4XYrPS0gql+MlaBX8F1S7trEJxMN19cgEba4sIRTAB2EQd6ER?=
 =?us-ascii?Q?hQA79TJufEnhpXhKwC01HMhq603tnr8BAZiNZH1Cca4cDdjN3mdAyvdUg4bv?=
 =?us-ascii?Q?9ZNy5t2bvilF58SQYeZNzDLkDrOMDmUYneaHkmxqz8CdJ30vci0+IaIrTW41?=
 =?us-ascii?Q?v0zkz7okiBLiMMoEJuxjYv8LYtE7yLOWY3Zk9I9DcPQHaljYRvNUjioeyFjo?=
 =?us-ascii?Q?RoN26pCps11VlKqpK6+G9vJZJb/tIlYC/HpKwsH/aqpPG1MaY/b7BHohmd6u?=
 =?us-ascii?Q?D0aPCOI6HQvhcBewsvLRIMJbC+8/TjDEfgBFktaMmsBOdt6fI8CqKIef5kK+?=
 =?us-ascii?Q?OIiHsa3kEAdNgZUctcuYnmt1gPLIhQDEZtwZ6O/Miz8Ah8FPP4CvXjVHbCE9?=
 =?us-ascii?Q?XFvPaULXEbari3n1X/Zszrnm7DPdEvm2K4XAy5xj3/bBAhxOCWVHCH6el6lg?=
 =?us-ascii?Q?eAj7ocRt4fI9zwNbtmOW0yi2SO7bfVNSkWLoDpu1Hr7DbsZ+ORrouVXnUI4p?=
 =?us-ascii?Q?mqD1XS4L4iFnXaK6CZbAYZIfSbBGhY9/nT2RuTyqgDje3q3ACBsu0NFVOhsP?=
 =?us-ascii?Q?rV4ud9yNFcse4NPbAGNkGrMrGXgwp+qWurC3eoO9Dw9NC+UglfXNNM4C1ydA?=
 =?us-ascii?Q?20cTIdTUyfXv7Rn1e6nC+gDvBYPzmtoKjioOJS/0DpV0u1qTaQVZu5j4aj0N?=
 =?us-ascii?Q?jNOxe1BvWiPAKTJOiXxG3/qSeXvSEuruCvqIVD2kXSy6wINNaQYxlMOfVH0z?=
 =?us-ascii?Q?7dctwMn1KsLM47OUahB4b3ODk39ez/65fXg+I13p3Te7Psi4jSYeh9yDHP8z?=
 =?us-ascii?Q?EvjNtbmAnWsFuepELecxAgnM7gCFR+4oHxK2bPbGFThSpEq+dflAO/Dqu1IX?=
 =?us-ascii?Q?k9yj/wfVwyECWY3SspidDYtg+7nAckIrJAvH6Q8f69eHQtmwiuW3n+QqMxBg?=
 =?us-ascii?Q?IVs51j4GHg7FzTU9FO3/jCXseN9vAyDkVsXVnn1dKBgWsICGpPmf6NphJVCf?=
 =?us-ascii?Q?tQIBl+u815BW6fWLzp5jTN8R+juqBI14X+9LgM+xeIHamZecXTPjBhIARZtw?=
 =?us-ascii?Q?CHawAqAMIzAIxbEKX46Ya6v3knKhplYcQmGzTEnbDwQEskRsIiMJzvPMvRKo?=
 =?us-ascii?Q?NufpcRHf2e4Q2w5myHDGy7a8stkZ1vRN9BWoStyh6sDCViV/71tfF8MHDc2M?=
 =?us-ascii?Q?N5aibXyn0wdq6+qBEWXVVSgafVyYWOsN9SePcwWVsBucCNCmcTq5a3muGUO8?=
 =?us-ascii?Q?6drq8EdaZFnNuI+arALfGjshs6cr2dO7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kqgrr6bvHLiRgvxEUN+QgomB0Ban9kxUNRXiDatyl45chP/VfXAlt8nB0O4?=
 =?us-ascii?Q?Q435go2V2orct8j7DVscanz8od+oERd4DiGPWcGmc4vK8jh1JMFiGLXtLRHI?=
 =?us-ascii?Q?exlDJgFNF6jCUmeUsp3U/aqdIfaVpIoRdlpHmcaHgah6m5c3vJjgDFy6Yb+3?=
 =?us-ascii?Q?EBB1atlPwytOJetyOMDuWUox4GI6+KIFlr1sd/mlA1iLAJ/Mw/FB5xBHRbk4?=
 =?us-ascii?Q?cckaRZSFeQ5vLvbZAycqalyaz+jTQ6Mb/0VikE6WRjFNcBJ33l6+m1WGaWoK?=
 =?us-ascii?Q?nKCwqjvmUy6lwSff9o9+P7ykeAoq9Wsb3B7yOTjPpadVXq+bYyzm53Vnr/Kz?=
 =?us-ascii?Q?p2fdMPSSlz5qIOvuroTMXacgEWNRyAhyY96e4LHeRPkdoSrMsHbBuvVyXrqo?=
 =?us-ascii?Q?coedjjE0FLmvobRLeKjOwCSm7W6ayDaYDnLXTo4A/vwgx5l2vHUZD4wbY3nf?=
 =?us-ascii?Q?IEKC6+IZ6H7PzfGZFvNfG8ZlMNuMxbKcqYuY+tMg6itfvwYW18fGew3Sx3Ey?=
 =?us-ascii?Q?l9uQTXVnPsqTfeUMhDyJO1nS6I47fA1e0o/2LCSI3zejTVtY1guZBHRiWrPI?=
 =?us-ascii?Q?66xdF54sSkbw1CpCLUP/b0fkk58wFCcAxP929DNgygCFTAasHhDVXxGJ8A4n?=
 =?us-ascii?Q?LgVO7dC2E7cDdSB70DT489Qbueh2ikfY8dXX2tl3g0IjuQK23t5BDNGZFw32?=
 =?us-ascii?Q?QHN1GoXY1tXkmhBpd8UUbpetMU0EKKwkvxgq3P8BLMMtiWc5dpw/CZDIfFFf?=
 =?us-ascii?Q?bGr6yfqNoEzaA+xWVsD8N2YP4u33CQuu9xaSKPkpMcuM3YSxbkaKnkRCkg57?=
 =?us-ascii?Q?iicWl2/yq+W8SXR5jQxNzhn5O9YaPFGRZ7IzCu/bJs7rZkkEN1oy3j7ERgqn?=
 =?us-ascii?Q?/LL86PzSvgQJ9cpa+5hG+vBdMWoIuWQ201lzWhQWU2U/3KwblOS/RQGmmk7+?=
 =?us-ascii?Q?/s/kQ4cl6oyk/c/VFj+RtJBDJpj9DWwlZV55uaP6vUsAaJZbyATiv8hbqmzz?=
 =?us-ascii?Q?PPPKV3Rpb6hJnb3y5NRxT0y0gfBVhWsDgRQ/Yn8fik7TPEtst59wQqXNlMvE?=
 =?us-ascii?Q?o+hckF1liiEkwWdp7t5fju11u/fnRf3+HrL6s3cSYDqZb9uoyuMIo9+Sd90/?=
 =?us-ascii?Q?icyn2ADRa+Jsh99fmrVcaM6+yKflwoNbAxFi92IXIqUf4Hv3KqAHkWCjZ45h?=
 =?us-ascii?Q?o6QL5w+44Jf1yggmBY4TWHVLX2JjN2D+n3jD34AGhWuXNkONQiIPeViQnv9Q?=
 =?us-ascii?Q?AVhHMuwfJXG60wNbVkhsRNUcdlVybGnePLRxv5dV1fSHEhUdamZWj1JJh2uR?=
 =?us-ascii?Q?ktau4rS6TmaCn6gto/hGeh1vxVXpASr1VHbo15kMpomSjsv5YRsUt2DbZVQH?=
 =?us-ascii?Q?CMoqIZgG7RdANfnM9beDrillkODTD8ilOJ9oh0BEZIqkwg9y8zLKdBcYysHC?=
 =?us-ascii?Q?k2WcKslpNIkoxfsKPdyK7h+cPiyvhgb+05b5E+8om9SMYg6zaQ4icnUNDLBW?=
 =?us-ascii?Q?Mk8Xzmr11uRKffA4YcAt6jAB21hCsER3Gu6ooARTyilXSlo5ENfZ522zI8Bx?=
 =?us-ascii?Q?NTQXnuH9cA4AFWmyoP+Olco7UY70DIQ1yydZMKkWentpw0ColwcmhQm6NCnP?=
 =?us-ascii?Q?tpRbwnPqXb2sXkMjrKD81VGDf273zaVikEM1WeKrKlWftdEir6pnVKQUojeh?=
 =?us-ascii?Q?Od7Tmb9UuTegxYYDy2zMlCMws2DDMpXgRU7h+f64rdmcrYzOutI8/o5xP6GY?=
 =?us-ascii?Q?cvcnQf9wpiu2LyaRuzzfEuLu+PXXCU5bSEIQkKHOVOEiG0xoNT6s?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5d24d0-bfd2-4e35-fc69-08de4c305040
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 07:59:12.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kOIQQGfgH4jv+q5HflvzuenW/vlmCvl6C63CN2A3IMb/1jJedqZ7qdISO/zI16bkR2KUmuGdeywNU/hyRdMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3165

When multiple MSI vectors are allocated for the DesignWare eDMA, the
driver currently records the same MSI message for all IRQs by calling
get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
MSI-X), the cached message corresponds to vector 0 and msg.data is
supposed to be adjusted by the vector index.

As a result, all eDMA interrupts share the same MSI data value and the
interrupt controller cannot distinguish between them.

Introduce dw_edma_compose_msi() to construct the correct MSI message for
each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
base IRQ with msi_get_virq(dev, 0) and apply the per-vector offset to
msg.data before storing it in dw->irq[i].msi.

This makes each IMWr MSI vector use a unique MSI data value.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Base: vkoul/dmaengine.git commit 7b28c670df45 (latest on branch 'fixes')
This is a spin-off patch from the following series:
https://lore.kernel.org/all/20251217151609.3162665-11-den@valinux.co.jp/

 drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..3542177a4a8e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -839,6 +839,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
+static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct msi_msg msg;
+	unsigned int base;
+
+	if (!desc)
+		return;
+
+	get_cached_msi_msg(irq, &msg);
+	if (!desc->pci.msi_attrib.is_msix) {
+		/*
+		 * For multi-vector MSI, the cached message corresponds to
+		 * vector 0. Adjust msg.data by the IRQ index so that each
+		 * vector gets a unique MSI data value for IMWr Data Register.
+		 */
+		base = msi_get_virq(dev, 0);
+		msg.data |= (irq - base);
+	}
+	*out = msg;
+}
+
 static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
@@ -869,8 +891,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
-			get_cached_msi_msg(irq, &dw->irq[0].msi);
+		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
 
 		dw->nr_irqs = 1;
 	} else {
@@ -896,8 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
-				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
 		}
 
 		dw->nr_irqs = i;
-- 
2.51.0


