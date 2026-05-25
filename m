Return-Path: <dmaengine+bounces-10866-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEMRLdEtFGpgKgcAu9opvQ
	(envelope-from <dmaengine+bounces-10866-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:09:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951295C9AE7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33674300749C
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A537DEB8;
	Mon, 25 May 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NpZFGyjs"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12737DEA0;
	Mon, 25 May 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707341; cv=fail; b=YAvdqPD9EcFpz85VzFARsNbMY6Vwz0fCjaa8uaGIswZreGW3pYH+qLfDptkuNZXdT6fMxPZSUjOxepQQgbIrI/74oQcfu9NNV3janmed5z6/chdrgEwwLWBLOyx8bOSgN5ZHClHOuS2WdYTA2ga0ANkW66ARlZLq6/+kKTy5pjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707341; c=relaxed/simple;
	bh=oNANOsAilDJW2llIjbU53WGWtudKEQoz53h7aEvYVsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyYxx5pe0Xh9rhHHkLLgnnod1wzjBlDw+9extP9UEFWRuhznl0bTmByO+2uCzkWxXseelMqtG20nJf3147Y3plpiSN+w5FjkidXwI7gbA1huSB3EYccTNFprEBknZs7hjUe9C2Sn2TwvkccjzkDkKND4xDOsTlEpSrDQX7HzDlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NpZFGyjs; arc=fail smtp.client-ip=52.101.125.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdsSaOiW4xxyFLCTGHPL+eviL37nRR3csqmZnZAxYsfVhb+yytZM18TLZ0QFver5AxhMw+Bnh9HEX21eL805FAJsHg2b15omTyVkILrC6OTZ9LEytLFfqOh23JtDawnjUGuckG6bX+qwR1M1DPza2DhZho/JtC/bjbStnNlacwX31jlSwx2N8a3+mwJVNmFA2LgPgjSBxw0rWbkJrjdf3PF5MP4iSxsBNdZeMg3kbAIaBnaXnaEK7H1G/nfACh2PYTsGgWBUTg0ttV9f9BivjUh0RLDYmurNMPM05dTQkNs52vY94YgLaSVc1O380wPX0p+dy/5S/Mgi8JmWemJWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcglgHZr5QyC0R05vTawcw1/gGitO+qY0TQybl5GZ1s=;
 b=IeVvZfizFwihBSoUL0F3Y2EmAWyYSdsjxxfKoyYLlzZjb1LbZ6+UBEl4d4MGpt8tau4I4YoC6kYrNe9emcffpfjY3/VCknCZ7DaRZAsb6X9CDjxc6oeRviL4S/wfeib6HX8RzcG9vS1OEbmGHVRUyNQUbFJecUdfzTw/2//Onpb20Vy//pRwmHVranAl3cUwYKVk6K1XU181yt3yhRVeGRuqkQYr5AVT+Q7n4lIvKRI7qzOPeojotY5u4UMHdorRMUy/7b1ZSdCYptI74DYs8fTlPgNMBn7KVbf+SDEA0cFUIh0dDfLYKqgMrnafiv/+k6mWWXNA2WFCQ93SJuyFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcglgHZr5QyC0R05vTawcw1/gGitO+qY0TQybl5GZ1s=;
 b=NpZFGyjsXE2K0iaLBXeKStwPpAyCGgL+NzqsX2XZs4owupVPcxTnvBdEQrOQZSihcevNnWeGcuO87jir1pjlBrc7BHqq4mRqQmF8QP8ygqjr6jADqtT/2MYh3zfSTIupFUDI+6j/CqVZNojacqU6feBDm2wc1uSUr+tkP31zdrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB8484.jpnprd01.prod.outlook.com (2603:1096:604:189::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:08:57 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:08:56 +0000
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
Subject: [PATCH v4 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing support
Date: Mon, 25 May 2026 11:07:50 +0000
Message-Id: <20260525110750.4020112-3-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5fdaec68-7c90-4d56-3433-08deba4e03c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|11063799006|5023799004|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	eC+X3wvbQqaHwyb+x4vvCXEs+T1dt2gPgdbE1o/QJo1asHx7xHgo6x3XZmjyemLuO7RqIpN9ufxIvUdoN9+BZRXpwV+QfxBcrujjeNc9SFGaxbmneu5XbYa6k/DnqQZ8z5XxuMsGwAs9pkf2o/7uiD56OaemSsKe8dR9iNemKxRdcmMWkUMx+4L9Th7psNmAhJtEJpYHW89I2pafvkiB1akXXBMQ/T34NLvC9cIKaqhaXm1VJwN4yvZ5ohvbwLbxPTGJgMFftv1KHyGgxUJuaSaUrFxLJaJ1mLQIXWQFL9q58Bum6Ztx9XK9O0Hq817PXJinaUev4N4s8FJyttLv23F9zWfjppeoY/Mb2dj++tyKaabXyhybG13EnVcTNLkmLd93HAOnOXTdBFp70ZQ5OzrN7hjwxDO+tIx3AJAjhpRWJdeXIJj4fXyfLToLYAf0Bd+fob70Cbir5VbzkWUP/OuGYc80JUM7xWRCqOv5WT81poXm7sWOSFLe93G5h9/8D8E8FBu/6Lfw4JiRR13REycvdkTzx0np0Bk6bKDGEr8UPkCY1GyXppPR9Cbb/vHYuCOlO2UKTLfeimuG1bDFFyo2XuFPUxh+neTOQRfkptaNdYHWbhSqyMyt8A9pvtWXUYRFMBYi/S7Oztfzv+xIek8zao9Te4VJGzWjCjM4Qp5OaW0NSrNSa74skyTPxPQf0YsxT9fp7dFoOc4l7WxiYql6Tu9bhTuXtZmLfY5oxFB658DUPadjkXhgSW5wuKtf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(5023799004)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzO+gCrtBlVO3cRMt4Xza9VeCuk6NXdfd4mJs0V/53OOXjTCBP5M1n7vnfBo?=
 =?us-ascii?Q?rWMwft67BP0P7n82u6Q1ayX+eD95ffuB7aKcYP1WOm/aXdcBKRw/tJU/QWrg?=
 =?us-ascii?Q?1c9uytPWLfusGTF5lFyZ+578BVZ7zcYYvnCr19fsQPtrp9Mw5fSO8z2JjDiK?=
 =?us-ascii?Q?IUBuMtv4TUDIOFxnVdn6K+/gh41LisALsDIkaGAZdg53/vK8FrCpEID3mGaY?=
 =?us-ascii?Q?5bAeK9y+h0Ic1tbgtk7y2OZZUAU+Ld2ygUhfBIME6f+LTcaudEuSNO4n57AF?=
 =?us-ascii?Q?Hv4S8li8VIO8R2+MraMuG8CvtBUSkbtEs9fOEr3I4x5tQibnfu4Gi/a9EY/2?=
 =?us-ascii?Q?H79zFDymWsXMm/NP6jLuu7Lzt6snW36rOHecxVlAwydekpsnMf/NyR7mTlgU?=
 =?us-ascii?Q?rmXSrK5pcWVXHAjYkULfAKdFD0D5+Y4sAEZ6irIxgRy/Pr3Xf6IZfw03DKCE?=
 =?us-ascii?Q?VopXpsNKjEhFGwGhGZaBCO1XRNEcm/tQtU3S5jnG6IBoAHf+eSMWLS8euKM6?=
 =?us-ascii?Q?virW23HCXh5JLHTkJOANAnh8U6L3DzaeMzEggTMCxppMffB7XKveu4YROGVV?=
 =?us-ascii?Q?yHjaWY2en/txuOThAoWqJZqCg6TVV/GIA+qwEBAA7ATSfwpmA8g8nJHrCim4?=
 =?us-ascii?Q?Dbg5vsMG7L0+Oxn+afH++3gjACmNkDjz9vWqe1sFP4+YK3tiIiZIo4HOCA+j?=
 =?us-ascii?Q?zJQyviID23mnLKvIHoo+cN0im/tAEjlekskHZziTChJ4Lq6pbOKOxhgE8jvi?=
 =?us-ascii?Q?seGRyAvPG+DnefOR2hUrcKIwHuB8tw9LENWtT9YXa+S2TiI3ag9MBN4UycwM?=
 =?us-ascii?Q?/hoi9+PAm8APDMFRL6oskw03dgvK01vFMSOPP4rDoFmJqafzRjeSKTc6z9aD?=
 =?us-ascii?Q?fTMTL9+RAMHVZhksD3j4KJM7Ub+PcKOw4hGuOCIg7OcX5CgGc4R5pdOYeACz?=
 =?us-ascii?Q?1hoZRmbfHHUBy5hgptiJXsC7OzhI+L9NTxw0lH2YCXDEhnsFHTeOzOeDRvGC?=
 =?us-ascii?Q?MWF6ULS3OhYbH9FfO9tFICbKF8sgQzJ2M6iRjmbLIw54cYfjRuqHffciwwVX?=
 =?us-ascii?Q?3IZfeegMbq+BQF+9QMfiTIxIOSkJD0VTFZExUghp4KQypVvHL9rt02QPk10l?=
 =?us-ascii?Q?qKoPbJ4Nutcvk5stvVIFVL30w3vN7yKXsPc1ZXaL2XmvnlOwV1Ula6eSNuoC?=
 =?us-ascii?Q?lZ7sVRyjlQdTC0CIjHMxCDxPiwGP27uLm1YJr9O2rxmdV7Dx5cYaihFdoEtI?=
 =?us-ascii?Q?HfAJpmZdJfQ8JeBP2LSCSMvvmJww4KGO12sgoDUrJqvCv9GsO0j4wEfceb+Z?=
 =?us-ascii?Q?KJNzctxNvNLOpt81o4JVQDdm/Xk4Xe167VxBxnRN5TDFapOSip2yG7wVgJZf?=
 =?us-ascii?Q?LE6dChSm03BeJbxoQsgxpL8fNlzn+/lCf2i3JKHpQeK7rEUw3IDEOucnNNt7?=
 =?us-ascii?Q?erhzc31r1Li1IDI3Fjqr/ntr8zttO/0y1oc1gIfeu+TIh91hE1hkEgmUCOKH?=
 =?us-ascii?Q?qz3czzibaH9KVNyTbvktd7hrG7p/QERQ/MLiTUfK3ezM/kFexnxAHCm6yqGN?=
 =?us-ascii?Q?TjcMHwtxExvZ4kPsXJ+tvhNBY6fuW0g/g7l0tgPO5DfAT6pjA5QZKAxVOdp5?=
 =?us-ascii?Q?1WPZQCygjFYKxaPxP79PHJKqMp49f4LQHzRxVETDh5bZydCeOvGclAmKwu1u?=
 =?us-ascii?Q?74mfF6MtXuPXOYfvro+ihTy0WdwPGGvBn1IBVY2jy5cAkEnSJqPFZLMcxXE8?=
 =?us-ascii?Q?Hv4aZKPRdnzY4GuNpw2QJ09ab4qQjyA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdaec68-7c90-4d56-3433-08deba4e03c0
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:08:56.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Fcth+tECVVJuSSayXIK7YQLFZS+sIFS0XLelRJzLQFzQwILOtec7w2j1kh4PqKq4A4SuPxNdX9maCh/opMvIlsMgx72tyb413GSn/cWt3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8484
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10866-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,glider.be,renesas.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 951295C9AE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC) require
explicit ACK signal routing through the ICU for level-based DMA handshaking.

Rather than extending the DT binding with an optional second #dma-cells
(which would require all DMA consumers to supply two cells even when ACK
routing is not needed), derive the ACK signal number directly from the
MID/RID request number using the linear mapping defined in RZ/G3E hardware
manual Table 4.6-28:

  PFC external DMA pins (DREQ0..DREQ4):
    req_no 0x000-0x004 -> ACK No. 84-88

  SSIU BUSIFs (ssip00..ssip93):
    req_no 0x161-0x198 -> ACK No. 28-83

  SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
    req_no 0x199-0x1b4 -> ACK No. 0-27

ACK routing is programmed when a channel is prepared for transfer and
cleared when the channel is released or the transfer times out, following
the same pattern as MID/RID request routing.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v4:
 - Rebased on top of Claudiu Beznea's updated rz-dmac series. The
   rebased base reworks rz_dmac_resume() and now re-programs the DMA
   request routing itself (rz_dmac_set_dma_req_no()), so this patch
   no longer needs to add that call there. The patch still adds the
   rz_dmac_set_dma_ack_no() call in rz_dmac_resume(); resume() thus
   continues to restore both the request and the ACK routing, the
   request call now coming from the dependency. No other code
   changes.

v3: No changes

v2:
 - Drop DMA ACK second cell from DT specifier
 - Derive ACK signal number in-driver from MID/RID using arithmetic formulas
   per ICU Table 4.6-28 (3 linear peripheral groups)

 drivers/dma/sh/rz-dmac.c | 69 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 19095a5492bc..f6346f31096c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -93,6 +93,7 @@ struct rz_dmac_chan {
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
+	int dmac_ack;
 
 	struct {
 		u32 nxla;
@@ -118,6 +119,9 @@ struct rz_dmac_icu {
 struct rz_dmac_info {
 	void (*icu_register_dma_req)(struct platform_device *icu_dev,
 				     u8 dmac_index, u8 dmac_channel, u16 req_no);
+	void (*icu_register_dma_ack)(struct platform_device *icu_dev,
+				     u8 dmac_index, u8 dmac_channel, u16 ack_no);
+	u16 default_dma_ack_no;
 	u16 default_dma_req_no;
 };
 
@@ -366,6 +370,60 @@ static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int index,
 		rz_dmac_set_dmars_register(dmac, index, req_no);
 }
 
+/*
+ * Map MID/RID request number (bits[0:9] of DMA specifier) to the ICU
+ * DMA ACK signal number, per RZ/G3E hardware manual Table 4.6-28.
+ *
+ * Three peripheral groups cover all ACK-capable peripherals:
+ *
+ *   PFC external DMA pins (DREQ0..DREQ4):
+ *     req_no 0x000-0x004 -> ACK No. 84-88  (ack = req_no + 84)
+ *
+ *   SSIU BUSIFs (ssip00..ssip93):
+ *     req_no 0x161-0x198 -> ACK No. 28-83  (ack = req_no - 0x145)
+ *
+ *   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
+ *     req_no 0x199-0x1b4 -> ACK No. 0-27   (ack = req_no - 0x199)
+ */
+static int rz_dmac_get_ack_no(const struct rz_dmac_info *info, u16 req_no)
+{
+	if (!info->icu_register_dma_ack)
+		return -EINVAL;
+
+	switch (req_no) {
+	case 0x000 ... 0x004:
+		/* PFC external DMA pins: ACK No. 84-88 */
+		return req_no + 84;
+	case 0x161 ... 0x198:
+		/* SSIU BUSIFs: ACK No. 28-83 */
+		return req_no - 0x145;
+	case 0x199 ... 0x1b4:
+		/* SPDIF + SCU SRC + DVC: ACK No. 0-27 */
+		return req_no - 0x199;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void rz_dmac_set_dma_ack_no(struct rz_dmac *dmac, unsigned int index,
+				   int ack_no)
+{
+	if (ack_no < 0 || !dmac->info->icu_register_dma_ack)
+		return;
+
+	dmac->info->icu_register_dma_ack(dmac->icu.pdev, dmac->icu.dmac_index,
+					 index, ack_no);
+}
+
+static void rz_dmac_reset_dma_ack_no(struct rz_dmac *dmac, int ack_no)
+{
+	if (ack_no < 0 || !dmac->info->icu_register_dma_ack)
+		return;
+
+	dmac->info->icu_register_dma_ack(dmac->icu.pdev, dmac->icu.dmac_index,
+					 dmac->info->default_dma_ack_no, ack_no);
+}
+
 static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -438,6 +496,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 
 	channel->chctrl = 0;
 }
@@ -491,6 +550,7 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 }
 
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
@@ -583,6 +643,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 	}
 
 	channel->status = 0;
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
+	channel->dmac_ack = -EINVAL;
 
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
@@ -846,6 +908,7 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 		dev_warn(dmac->dev, "DMA Timeout");
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
 }
 
 static struct rz_lmdesc *
@@ -1175,6 +1238,8 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
 			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
 
+	channel->dmac_ack = rz_dmac_get_ack_no(dmac->info, channel->mid_rid);
+
 	return !test_and_set_bit(channel->mid_rid, dmac->modules);
 }
 
@@ -1211,6 +1276,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
+	channel->dmac_ack = -EINVAL;
 
 	/* Set io base address for each channel */
 	if (index < 8) {
@@ -1583,6 +1649,7 @@ static int rz_dmac_resume(struct device *dev)
 			continue;
 
 		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+		rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 
 		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
 		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
@@ -1607,6 +1674,8 @@ static const struct dev_pm_ops rz_dmac_pm_ops = {
 
 static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.icu_register_dma_req = rzv2h_icu_register_dma_req,
+	.icu_register_dma_ack = rzv2h_icu_register_dma_ack,
+	.default_dma_ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT,
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
 
-- 
2.25.1


