Return-Path: <dmaengine+bounces-10865-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHdHOV8vFGqUKgcAu9opvQ
	(envelope-from <dmaengine+bounces-10865-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:15:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FE5C9D3F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1AC304E0C0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8D37DEA0;
	Mon, 25 May 2026 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u9Nev12y"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010019.outbound.protection.outlook.com [52.101.229.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E337D128;
	Mon, 25 May 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707336; cv=fail; b=MvQd293LPGIG1lKI9ZSCtOgoWK/MTx3L0WLOI1tLDTCLON04W7Fu+S9aVkDFtSceK0VtRCntG3D5/dXHdZYll2a7LveLzXVJ4I4Brgf4ZknnOHlAway1HbRAJJVuPSf24S27tO5Cip9Tc0j+5OzkZkzo6xemysQsJi5ZB7FhLLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707336; c=relaxed/simple;
	bh=HZEdZk87ZDF1ONfn8XeCx7vL+BvtgchcneNH3u3df68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhBkJKbEA6/YPIvXCdMvfA0DUFAixWEqsmWY4hHp9spDP0pR/8PWtnfSIi6TS2hEnTVZlGhm3PqeTt5+SbfkkZ1/EVz6xXwtXCgC+lBCwEFN58qlOggU23TriyFA9CeMqHJ2V7igezeVp5J+M/zsPXkK7zJpDniLnRhhbX8LiRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=u9Nev12y; arc=fail smtp.client-ip=52.101.229.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z756Nx7Z7ClGYma/hlF5E8OaXYE6M63kygL/7SsIH1Og5QEFj4OUv+02AhngqhYb+yazydZLKhFhk/gwfwdjQ7185wSJ4tAU1fugqCN7ya9n/5hVAXqO0jGYsQdDTdSKwScDZlAieWOUYpClQxWbHHZNxQeZx50IPUvHS+ZA5QMA0zHPPQbF1BkDtrPyhIMS3ZZsI/j86KcGsrDxGZNc027v7Nl049eew43p+fbdnolljvLH+8IAohx+KYROjxZwsoqbRPtOCXlWSJJ6qZZPMDcwypOoqyRZ3V0aOWKMOl/Zrt+NvYL+DuxWEdM9OMpd8IwBO4MXZLzQgGlegtOV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tltuaXtSIEzxzgc7Ug+RTRwaBNxPvKW/uEXWrOE/Z68=;
 b=ATzUWs2O7VS9430mVM+bQR4S3OCvJST1p6ATPeEGksN1urcDTA4JY0vczKViDvDbPinLccNJUWXuZAOMe4VLLy2W0z0/zywwysdfXgDe0Jdl85V4uZKoxJ9QcxAHZJ7Iz2w8E7HRX057vRkSig9NNNMxR3pFdsuWo+6NUIQYwnkdjt0wzZb3ADlsEhZdoLHW9eUcatqiNhYqLSXN6yzjiC0geejfFYaTcdfzI6K+Voi/ybt8xolamACdLWAUPuacc4+y+4xB2NKeuzpj9vzNQAkVY+WK3ywUcT96Ez1G4sOKc3SpAO4xYePziSCf5nCyEhYHfnKs0l95WFaqnXnj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tltuaXtSIEzxzgc7Ug+RTRwaBNxPvKW/uEXWrOE/Z68=;
 b=u9Nev12yAR5n7lAKD778aJzVrcWTu+J97SAmUiAC4FgU8Vs99QOkKs1uW8Wd0g5Wt0IcRM05sUbNnPManno9MJMlPU6V+8Cxfm6JWKvCKjUS7F+qvFyLsisu8AT1ETEARqEcKswemOAOfVNkUH5envbrUHNxkU0AbxXuhSA75lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB8484.jpnprd01.prod.outlook.com (2603:1096:604:189::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:08:52 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:08:52 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: vkoul@kernel.org,
	tglx@kernel.org
Cc: Frank.Li@kernel.org,
	claudiu.beznea.uj@bp.renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	cosmin-gabriel.tanislav.xa@renesas.com,
	john.madieu.xa@bp.renesas.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.madieu@gmail.com
Subject: [PATCH v4 1/2] irqchip/renesas-rzv2h: Add DMA ACK signal routing support
Date: Mon, 25 May 2026 11:07:49 +0000
Message-Id: <20260525110750.4020112-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260525110750.4020112-1-john.madieu.xa@bp.renesas.com>
References: <20260525110750.4020112-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::10) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|OSZPR01MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: b66f3c79-1727-43b3-db4f-08deba4e0110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	gxP1eIjamIra1OGvyQqx6/sjq586+nDRcdN5xPQGKyeYupnPQqqlney8Y7KiHHF8JD/1CVqY0TaJLAM53QnwMvwjaJzF4zZa/aY2LCTfEymooPplFiUnUC4tuMwRiPrSo4Oap3HLYLY406WRG1aztMRvxgbfA0V8dcdWXOOy42Z5qMODMMa+ELxVVO3KT22ypLiM/AynMY8nEAU3y+ppspp+M44EEHa+5xX5KQWb4mlp/EbRO14eAR/6KOfCq0dtFSgsBpmaDVHOVp4QvJAmtwjEwxmkiZxeTKY7cyA1lQ6r8/NN+aIYy4Nnje0243lu0CC91mlNf25SLxHB869R5ZKnB9mr1DOtHoJY8rvuPG9cfNVs72BpjlQWUDCBgsono2LrCRXZKfMNTa89NKUBcg/nopJU1U2J5v4lAmFfDrDSm9PKpnpyXz5YnwHa32SEMGHLWK6XR+QPr2FEMCtzLuda+fkyoYJ+tR0o+aEgr9G8AGOgtEin1vIL27tYOyrNxKAhFQDHGYd8OE16kUh01HVuxlh/Vq0b+OIlMtKDQ9Y/BDLbwKlZaCoevGb+sTf4hrVZGo14W/VYP5MRaUlsNhyhgHG8JgIwppwBbo9EpQOPN4Ngiqjxn22Z9qZzwmk3DByU6Bx87qLCjPIUi6KPqo6VFvMhj6jjh0102i3ChH3KlZCblSg0iB5BLnE2JZ4bIJbBQTnWiWooGLT+1jn7EuzXfKM7AzPKadraEW6nV/z5Ykj/9ftTFnfHRFuesajR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8u55wVZTlMLL4SEHo8Zj7/GuDmukDdaPSjWPBzQ2b4HKLKjgq0rgpzy3I9d?=
 =?us-ascii?Q?C9ILlTTJPydVmP7hY8atorS8DS47CzDgq0iS9R22D39ASAS15Ue5WC7B7RL3?=
 =?us-ascii?Q?bAGB4JQC7NaEVw3VMDjyb9llsoTQT4ye9TEOz6IqYySY5wKPHch/CzT/sLjF?=
 =?us-ascii?Q?/5dFkVhkgmDT6dhBXNwwhT8N3z1TB5stNjMh13Boqs1sKLKXdtpzK9HRYLbG?=
 =?us-ascii?Q?oQs4SPayC2OKp+PsYR1OyCR+ywz89OaWyewgy4qBKF9q/3ZXDiPd/0KdZuOS?=
 =?us-ascii?Q?7tijK7g0Tjrx0Sak6xfUSQfunweRwivC41jA4lCRalbl8VUP063DXMy74fh1?=
 =?us-ascii?Q?ywKwci0rNINg5OYvReThqI18l/46OTNL0Z2NlQkC4KYTG81hzUTL7GqoFnN9?=
 =?us-ascii?Q?+vO+qndqmxxJy/zc8sKiJ587Bxz2OnBLla9gymVCGcTOfNadwzSFocrb3LWI?=
 =?us-ascii?Q?xpXuMnWlJkOM+Xvi/X5U4vx0birjicZO1Gz/RP5vM3wr4wnEmy0R7gx6r6HS?=
 =?us-ascii?Q?Q9Jc6WnyEeE0wYUQPH5z8DxVEdGJVb/DntV1tFoX29Q7xg5HxHWDXiFKBpY8?=
 =?us-ascii?Q?T6r8iT4Cn7UhDdvpDSDLbGDnmMiyy9f0Ad6TmgYGqxN8IXDGf1Zlo/OrXV41?=
 =?us-ascii?Q?sFX09K/b7n1O5tuTVwZgR8zYwTs+U9bFew7Y+naBq+45ShxLw4OOGT09mxK0?=
 =?us-ascii?Q?79r0fKr+BoroCQks5z6Gx7LtAKp5vDtKXtinmVrl2cy3WXjOSXYKJZiJNA77?=
 =?us-ascii?Q?K+GcatB9E+uNhdfLuz1zR0bRizZqFfAH+/DkqjQv0p4yl8HD7ksDIdUgEcY+?=
 =?us-ascii?Q?KCy2QGAJcNYSkXddVvSi7FknMahnF+dXVTdX0DEUL6vI75srDUGiX2lmuvf2?=
 =?us-ascii?Q?CS+tN0mbKbvEn3rnv8TPSEE7j+DRqBXqNqYf+n9m8MCnYK32dhvZiaGDvtvj?=
 =?us-ascii?Q?MfWUQV9yHHvZXyy/nXF0Y/iLsUpETmJHm6akfYAC1PA91+SVPsg7Z9IUToBv?=
 =?us-ascii?Q?VYV8mq9sYcoTNgiBe81zhgYf+hZiCMMIJacSWOr/e/enk2Z/0pm1j/avTGrW?=
 =?us-ascii?Q?kJu4qVzZypZEIME3ODCYQj9ZwBSh4k/HXUmJIXv4IdGq5a2vyI3SohvgFzcY?=
 =?us-ascii?Q?Xqp8TVwT8kMHKvEPZT4eEs6z9ZRegLOM9YTB6gncNqd+CM7sGi0X76/nNEGt?=
 =?us-ascii?Q?M9fOMO1yQX4v5ueYSTahRccfy9eJOpN2fW44nY6edwdsGnZpfjzcAoG00Hl4?=
 =?us-ascii?Q?9huFBVtAWcXzCcZNtT9bpeORJfD3G5G1p9Kfk/axge2kE4lWfmVciCLbpjFp?=
 =?us-ascii?Q?puC5P4yjh4A6nZzrblbdhH3kYWhwpI51mh1g/J39oSugXyqGurx3WuMZD3k8?=
 =?us-ascii?Q?/pzti/gGqr+8eSIlS4j4p2azpwTxpJz2vcyHKfD3V3jDLPUEfJdESue8tz2q?=
 =?us-ascii?Q?eNprPfHloCNLymoS9TTc261b7mgQ35vNd/kX0cUHid/L0bXmAUuHhh77kkX1?=
 =?us-ascii?Q?CVf1nCDXF86OiLUibMl7aLAnJvm4OaleeVxLDm0sjYcQDDjACAdWRVifvU5K?=
 =?us-ascii?Q?uZbs4hrImNgaQwUGFAa3giAPCIgfmDTJHKWutsMP+99GOXHaYKNjnOsw6c50?=
 =?us-ascii?Q?eSiPCCuuaKK4s2VN8irShm+b603TWFcAZi70/+zaTxLOMxnW/sfQQkBArM9m?=
 =?us-ascii?Q?tIWhYXFSU4MUc1/JFx9oQB0yqUcxQIBUynMYO/o5LcgVTHQnVCq66fyMed8P?=
 =?us-ascii?Q?L680/G2twjUlJNrzjDKoGPIMPYhQ4jI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66f3c79-1727-43b3-db4f-08deba4e0110
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:08:52.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcKlYKtnOEF20arnbJRLkaPqMOtmgozEfTQmSO/Dif1z6WeW1ezZvCSlHwdkFVNVRuK+9OIFhrVbgJljfdN6ZnGFWGXds4g3kWg7nKtBuhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8484
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,glider.be,renesas.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10865-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,bp.renesas.com:dkim,renesas.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 875FE5C9D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC) require
explicit ACK signal routing through the ICU via the ICU_DMACKSELk
registers for level-based DMA handshaking.

Add rzv2h_icu_register_dma_ack() to configure ICU_DMACKSELk, routing
a DMAC channel's ACK signal to the specified peripheral.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Acked-by: Thomas Gleixner <tglx@kernel.org>
---

Changes:

v4: No changes

v3: No changes
v2: No changes

 drivers/irqchip/irq-renesas-rzv2h.c       | 40 +++++++++++++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 31c543c876b1..971ac83eee90 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -151,6 +151,12 @@ struct rzv2h_hw_info {
 #define ICU_DMAC_PREP_DMAREQ(sel, up)		(FIELD_PREP(ICU_DMAC_DkRQ_SEL_MASK, (sel)) \
 						 << ICU_DMAC_DMAREQ_SHIFT(up))
 
+/* DMAC ACK routing - 4 x 7-bit fields per 32-bit register, 8-bit spacing */
+#define ICU_DMAC_DACK_SEL_MASK			GENMASK(6, 0)
+#define ICU_DMAC_DACK_SHIFT(n)			((n) * 8)
+#define ICU_DMAC_DACK_FIELD_MASK(n)		(ICU_DMAC_DACK_SEL_MASK << ICU_DMAC_DACK_SHIFT(n))
+#define ICU_DMAC_PREP_DACK(val, n)		(((val) & ICU_DMAC_DACK_SEL_MASK) << ICU_DMAC_DACK_SHIFT(n))
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
@@ -188,6 +194,40 @@ void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
 }
 EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_req);
 
+/**
+ * rzv2h_icu_register_dma_ack - Configure DMA ACK signal routing
+ * @icu_dev:      ICU platform device
+ * @dmac_index:   DMAC instance index (0-4)
+ * @dmac_channel: DMAC channel number (0-15), or RZV2H_ICU_DMAC_ACK_NO_DEFAULT
+ *                to disconnect routing for a given ack_no
+ * @ack_no:       Peripheral ACK number (0-88) per RZ/G3E manual Table 4.6-28,
+ *                used as index into ICU_DMACKSELk
+ *
+ * Routes the ACK signal of the peripheral identified by @ack_no to DMAC
+ * channel @dmac_channel of instance @dmac_index. When @dmac_channel is
+ * RZV2H_ICU_DMAC_ACK_NO_DEFAULT the field is reset, disconnecting any
+ * previously configured routing for that peripheral.
+ */
+void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+				u8 dmac_channel, u16 ack_no)
+{
+	struct rzv2h_icu_priv *priv = platform_get_drvdata(icu_dev);
+	u8 reg_idx = ack_no / 4;
+	u8 field_idx = ack_no & 0x3;
+	u8 dmac_ack_src = (dmac_channel == RZV2H_ICU_DMAC_ACK_NO_DEFAULT) ?
+			  RZV2H_ICU_DMAC_ACK_NO_DEFAULT :
+			  (dmac_index * 16 + dmac_channel);
+	u32 val;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	val = readl(priv->base + ICU_DMACKSELk(reg_idx));
+	val &= ~ICU_DMAC_DACK_FIELD_MASK(field_idx);
+	val |= ICU_DMAC_PREP_DACK(dmac_ack_src, field_idx);
+	writel(val, priv->base + ICU_DMACKSELk(reg_idx));
+}
+EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_ack);
+
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
 {
 	return data->domain->host_data;
diff --git a/include/linux/irqchip/irq-renesas-rzv2h.h b/include/linux/irqchip/irq-renesas-rzv2h.h
index 618a60d2eac0..4ffa898eaaf2 100644
--- a/include/linux/irqchip/irq-renesas-rzv2h.h
+++ b/include/linux/irqchip/irq-renesas-rzv2h.h
@@ -11,13 +11,18 @@
 #include <linux/platform_device.h>
 
 #define RZV2H_ICU_DMAC_REQ_NO_DEFAULT		0x3ff
+#define RZV2H_ICU_DMAC_ACK_NO_DEFAULT		0x7f
 
 #ifdef CONFIG_RENESAS_RZV2H_ICU
 void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index, u8 dmac_channel,
 				u16 req_no);
+void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+				u8 dmac_channel, u16 ack_no);
 #else
 static inline void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
 					      u8 dmac_channel, u16 req_no) { }
+static inline void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+					      u8 dmac_channel, u16 ack_no) { }
 #endif
 
 #endif /* __LINUX_IRQ_RENESAS_RZV2H */
-- 
2.25.1


