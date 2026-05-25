Return-Path: <dmaengine+bounces-10864-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIPRAsgtFGpgKgcAu9opvQ
	(envelope-from <dmaengine+bounces-10864-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:08:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B485C9ADE
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C21A3005996
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358AD37D136;
	Mon, 25 May 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="YYsHlQMF"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED437CD44;
	Mon, 25 May 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707333; cv=fail; b=R8BWRJXcJ6PGMpxy77SnXoAggPMcjBLO5USQousmkofhDTYb0gtOha1ZNslkFukYS2Fyr+dG0WNK1IpUds73J3Faw3KcUirhPETiomGBeYh0ZAf0UdqPdcZEJjxe4wsUGTIIucR756ZhWllN/MaXNVtpuPEvVDl5M0BOQLRkw7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707333; c=relaxed/simple;
	bh=0J7fbAIKYasqTa96Ymk6Dptb0W3tEnnsrU7l9cuLoeU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FWtV6YXwVo0KcP1QfihcTfGmr1X10kDoMNf8A9uYGvklK5uAPADdbEZZO0jbpiU2syc2QxJkGRA1wPXTcWibz57BiCc0lKgR1O9Jy4mh1KJdEFG48x8vsADpeWsgb+VPVuImlWckDelSmkgHEis09+9Tjkepc5EfATCVws0x8xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=YYsHlQMF; arc=fail smtp.client-ip=52.101.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6AXdbVW+1pSSTFItWQnQ0J2jErOarzEk1g5W5x5oDo7Yvk3ljl0O/aV5Jt1/s8OCmBaOygnKeFb1GN8W5rEpbrGASrRRUSzmuhgy3bI+qxU/beEACILAWQHUMQGukCT2yw/gexM0/m4IoiWT+9yxPtJcWOakM4J0D3/g7KsqlfBlif8sQgmjRHvUS96jAulvgYIFyxdsZK1Tx0C3Fukb++3bRBT21q8fHFilUU9pgleqxDa2pUxGCwV77daWVyWMfBf3A4VMxorg5+OZRdjArSuD7ueC2KP7MlExch9MVabWVvmisjdRDNB1HJw46YpbApy3t6sxh8CtZDyJuWKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CMZvOAN9FcMjbgQKzBXaofkTatlxBd5YzskZp4rh8I=;
 b=dKu8NktmMQjq7woi6V3q8xHpreQNBKWvDFTfr3dzGx8U4DrvFi3WzTYZJoudV/RVW3xfLYugVn/Vi3brN35Om3f1RR13SyieSLyqgiG4bFYJNWCsUb2pu+celmWlWf+R7OpswnFCWjcXBx3eP9bH0tTN0oDyF/r1u9eDRfBhNMMVqXP/K3BLqLiTnmXPjN3LOdIlBbWlXFZG8CbsLE2FwCC8bD+YhNNmb9PfavRlRtVc0v4DnKgWixTUEJhpa/fdRxkVYhMmBS7Nwik4mpEnRZQw3Uagcu0jaebPGahqB0xNbLwku0IChPK0Ec6cXOKdsxrruMcszJZ0d6bARkztXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CMZvOAN9FcMjbgQKzBXaofkTatlxBd5YzskZp4rh8I=;
 b=YYsHlQMFtQAqaLn6B4+MZK9CGf/RP2RQTdcGauw6HKCngEsURc+zh4qunlwO7smXDQqJUJSO3yp4tOtBgkm1yZFcy1xwjbfAi8T3x+30frYo7pRXx6vOyh44JWcG8qTZhmwspUMY3KlE2KLVpf/ZVVhuS6F8/h/eZqAYTmpoyc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB8484.jpnprd01.prod.outlook.com (2603:1096:604:189::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:08:48 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:08:48 +0000
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
Subject: [PATCH v4 0/2] Add DMA ACK signal routing for RZ/V2H family
Date: Mon, 25 May 2026 11:07:48 +0000
Message-Id: <20260525110750.4020112-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 6d5b038c-4fa9-469b-5002-08deba4dfe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	r3wiPsNN3YLe3F+tRiXgLiQk4JelLgMnieC+3EGIDUinFq04Um8aZXS+fRDbHoIunfOKGr4mbur0XSgch1HjO7df1Om1ueYTqwQMgX/Rl/nbHaGYfgeJ0cLR8RyQlbkhWoPPUQmf5iW5+/oM376ZaC2n1vAkWiF9exmQ3tFAGWfqTIAsUn7m30/k3jeZQPMymL/RD90tMslP8KGaepY2XntV4GNjln8gp1t8K4KltAz8RaqZiwZCze1hv6BEJgEyMfltx/kRFYztipPMxYsrN9cBbH0sSS627Vuj9hzi/hsuc9TP05Rd2XZpZVxnFhR5qbrJJK5nr+t7yCEBpE5hRSbgqoEvrEKMbYpYyPqxXJROoaeSHIgZSyeUM4/f0lwR/lJzMRcGiOKWrzn3EAhZXuO3lVnw7pQDWOykjEfQvoRr9DecZ0C4Vwc2Vf3644X9gJE0YqkeNdx6niKl4uTUQ0qH/iRX93DDF7ZElXewigvQdGxxsvADYtfMxu/LgYBKutORNfZJSPMgTishguqCc30dm6ycXX9nak/v15lfY4MgCAESF/5xLR/I+AUQ4uYmmX6b3ANFcOVW79rwZ6hI+iyIC/ojQnqspFh3aGviUx2J/qngWViVzbMPongQNxrfQNe27cA7CmEx5j52yaBLbwE36GzJmxPI4tBoTyEOq7If8+UcZkayyTCP3T2PizPkLdUWZtGRe19bZAJ8kRlU5mF9fy4BPPrMcgaZQYqC1RZpVpqvNaUH61M3tKdeKtJ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ufg+NINqPcnACnvdgH9Q5Nxz/f+LhiL2ooXiCBMqHzzCcSC6XK7d0tep76UK?=
 =?us-ascii?Q?E9rwXpbTDimMzuu5B4aBDzu7iqELFf9dN5NUc9VhdAWZzyL/drXRdryS/AXm?=
 =?us-ascii?Q?wS+zxWbDDjl9/B/dR6JEHQ/d9IaHzyUyhMFiCzItYTRPWwsa4GIFNJVdlQiK?=
 =?us-ascii?Q?SFf4q8kcPuKDoIQAYOXzIDJn+N4cI2dp1yptAFR8Z5vAB3cDpnS1YTItgkpT?=
 =?us-ascii?Q?wZ2tuDyJyzTbBF1nsN6aAktaty90M5PyDkMHnr+zCoTLZWaFJWKumiwwQzzO?=
 =?us-ascii?Q?9rNMFRPj67Pf7KLTBODQPspwy0DNQb+KNptV2Ici8KCTLO2bd1DJfKZhz5D8?=
 =?us-ascii?Q?Z3tyF2+uwZnU2BD0ztVDRABmTU1JPw1/irI0YAtTdFluc9DHAV2Q6APclaPK?=
 =?us-ascii?Q?xna0LbppOmyXO/QAwRYX/9JwNqU5SBtbKf+HLsb+VKdC6tu5PbhvFBT7vbSZ?=
 =?us-ascii?Q?aIyTo0Vz6U1gHT1dgB5BG33n4wWOq+3cR2kb0b1/wfMloJSce+51NHifnhYu?=
 =?us-ascii?Q?5MLxwPEfnr9VxoEal2rGHzIvXTvK6uIQg7fxWZgXWKZHJvaPZm6qwIXdaqtU?=
 =?us-ascii?Q?U38aAsuhYEElQJfPayaT1+iflcI4qdVX3O+aTyxdPj6EGbFJEGJ/O+m9+Efp?=
 =?us-ascii?Q?BF4R3N/aBM6B7izFsRjudjHK162b6dmUoKFDwbpNLUlTDQ3Caz6iDu4lwNfJ?=
 =?us-ascii?Q?D1yRdEO4+46Jw1mDj1AjHbBooxwxZkF5LZqBNXzBxmEBzwSz6N2uk5h7MdOt?=
 =?us-ascii?Q?e4B9Rwx44khb9NDf/ETE/hgzH9RrKHpUoXHUyPSydWMNv1yfP1Kkmlu2MNPS?=
 =?us-ascii?Q?Pp/aDTZz/82Ho5K3jzOVZZ40ylWpMxSw26cg2T0nk9PflWitnE0Hs9aQ5dfN?=
 =?us-ascii?Q?KDAOjyuwuEp+h2JKK/vTlpkiZYvCepopHBCzGStTbjtO2qVPkT2Wa4yOIxs9?=
 =?us-ascii?Q?3jzFMvdBgUn61eHua9kL27+Z8wsSjvclckTZRWIwGoeadB2MT78eAWSk1KGA?=
 =?us-ascii?Q?iz92hgZpAUQL5JRyDG8OsvHifHHGNYilgt6lepvW4IZd4JrRt1tB6xPlEeYs?=
 =?us-ascii?Q?D0txl5TD7Oe/+lFzHH5XYQh/P1Ynl0cZNwb/qpdzkWOpY+rAhBgsmqSEiUXB?=
 =?us-ascii?Q?zxPaXAa9v+9MbArJpiElTUYnKgL4tK84s/j4D8YZC/SYFxkmEHFjLdS7pO/q?=
 =?us-ascii?Q?fonCuLGlbVKtg1itv35p8/6VOxInIl0a8rO3hww+DhlN3QpNTPYXb8TmK17w?=
 =?us-ascii?Q?FlfigmK+pxOIgkyYgfm4UFJSLiMTG8glnGCRHkc8R8d1d0Xw3Prq3T3oOY8s?=
 =?us-ascii?Q?d1K2s9DrgMmcZSI/UqnrVSs8cPy8NZ2nyoEh4g70+NgNWsl8EWgDBvRapUQh?=
 =?us-ascii?Q?QJakCrK+heDSlOxsNz1JFDrdWXYtgbtCZFiA9v+N/J8EnQMPKhDyfPt8ER0S?=
 =?us-ascii?Q?WXf/lT9FdyqI0uUjzXsA0MWZXzV7D1yQqJbUC9aH41sI3DPPtJP6BaVpxEBc?=
 =?us-ascii?Q?pSJCrUzC46dwtp31mlgILEdbmf6xGosvwTY2yCg2jHIuz7EPvs9YfYrmSPap?=
 =?us-ascii?Q?c6YNygkIDx9610WNmbCO0V/cY2TYa2R2brtOpX73c3HnAxeYPChrv0uSVttX?=
 =?us-ascii?Q?Ufy5VvTJU8LSTed6r1bQTdq3LSZ81nwalUUBbqjzOzjpa+fKi0xhF9/35Q/U?=
 =?us-ascii?Q?8ColqYNU4FJ1MS3V0Eca65O9uf7dzFbZ5aeNSac5ZlerzpZssG/7neG83u7Q?=
 =?us-ascii?Q?eEEiKVVpMzx3+ZG3fVwmh8B+rX7bPWw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5b038c-4fa9-469b-5002-08deba4dfe79
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:08:48.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koeyfDwHAEdL1OJbqMO9HnA2UDckt8EFt+sle5RdiwxoFQOqZkcyxXx5U0wlC/DX4YSmOSWO3gII+7MRxpIaRtdK+mdpTX+FxAzeKI+7K9c=
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
	TAGGED_FROM(0.00)[bounces-10864-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 98B485C9ADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/V2H, RZ/V2N, and RZ/G3E SoCs require explicit
DMA ACK signal routing through the ICU for level-based DMA handshaking.

Rather than encoding the ACK signal number as a second DMA specifier
cell, derive it in-driver from the MID/RID request number using
arithmetic formulas based on ICU Table 4.6-28 (3 linear peripheral
groups). It must also be noted that DMA ack register is located in
the ICU block


This series adds:
  - ICU driver extension to register/deregister DMA ACK signals
    (DMA ACK register is located in the ICU block)
  - rz-dmac driver support for ACK signal routing via MID/RID lookup,
    including restore on system resume

Note: patch 2/2 depends on [1], Claudiu Beznea's rz-dmac series, which
this revision is rebased on top of.

Changes:

v4:
 - Rebased on top of Claudiu Beznea's updated rz-dmac series [1],
   which is now the dependency for patch 2/2 (v3 depended on the
   earlier posting of the same series).
 - patch 2/2: in the rebased base, rz_dmac_resume() already
   re-programs the DMA request routing, so the patch now adds only
   the rz_dmac_set_dma_ack_no() call in rz_dmac_resume() to restore
   the ACK routing on resume. v3 added both the request and the ACK
   call there. No other code changes.
 - patch 1/2: unchanged.
 - Link to v3 at [3].

v3:
 - Splitout from v2 [2] into DMA-specific series 
 - No code change

v2:
 - Drop DMA ACK second cell from DT specifier
 - Derive ACK signal number in-driver from MID/RID using arithmetic
   formulas per ICU Table 4.6-28 (3 linear peripheral groups)

[1] https://lore.kernel.org/all/20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20260402090524.9137-1-john.madieu.xa@bp.renesas.com/
[3] https://lore.kernel.org/all/20260402162212.12016-1-john.madieu.xa@bp.renesas.com/

John Madieu (2):
  irqchip/renesas-rzv2h: Add DMA ACK signal routing support
  dma: sh: rz-dmac: Add DMA ACK signal routing support

 drivers/dma/sh/rz-dmac.c                  | 69 +++++++++++++++++++++++
 drivers/irqchip/irq-renesas-rzv2h.c       | 40 +++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 ++
 3 files changed, 114 insertions(+)


base-commit: 0337d5cbd9d27c9a0b418aa7da92ae20e59fcc7e
-- 
2.25.1


