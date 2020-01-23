Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF64146AAD
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAWODY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:24 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:5788 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAWODX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:23 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 1+r07DdaUh+XQv8hlJbv0xXZY96lWW7nM1Eilhy4SoIHuZ33tiFyFGSWUX3nEMwiZIzZpp5VG4
 o/MNY0Xpuvvyvkr20RrW7NTkZeFeEBBK4Q+wqkN5kvKdqL6Txb8+81EToc6QyMAu3kerIOK4UB
 4SaiP4JPDR88d6h9bRQaeRqDuI8URpLIx1XnWdoJYI7x5jNjrsajqP9ii/xhtq6xKc7CJ2t+6q
 t16UQ1UouEF7TCAgpOJjrGe/tkx/SxZjpjBMJ64/nN2xskiI0EiZijNN02T1EZDtRrbvkk5l/F
 YFY=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="63527842"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 07:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWF/MsXrZaBR1Vr4ka6C9BHu9h3WwoHa5w3ey8V9NOin43dgBjGfoSIo2wpFfBfH9vUGwy9o6Gs3efRwhLkhAdFv9sK+uRdlAzqSRA+6li3s6vCMw0CQ5qq3dwsrq2N+gJgEcY6HmcY2izV8S+uCexzXU2QTLuV5nxudxNy/in0gS+aMENBiYE1jq3KGYkqS3FzWAZ4BXO/ZH9NYa+5vNiwstzSZSbCF/h1YgkN86e2qd4HfEC5vv/K9VFRc9Vqzbf27VTALIF70mMNVftxfKKa9fIhOtuOQnzZ0FqWzBPA21RVTkYpSR3PRiSdasUwITVNKYdQdwqNq8Do4QPefzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdCT3Sa8zh6QvGLW4YC8E3cNO8031UJEzEhP1u7g2LM=;
 b=mzXPTyy10QmBbTL0RPqUi4fyZ6CJ10ZDNYpEKIGdSDl9BdTcVVtloSgWOoCE9RUm2x4zh4PWflfE2FgdTtYNL+9MX4LQWywbtxpTMcraHolAcZdjQxIV+zEoBxS09l1+oHqvIvpm1OhsJ/2KFq36+OaCcx1GrcW1cEOlUR2VnFXrwpNddE9k0BM5SWvgUHgKYjRzgOYAUCFlLifBdOC8UfefmWdiqB23wtJtqoN+h/nh0ruH0XIZLh9FSM0YuE+GOgG37dCQ2yvXuT6d/9rtF+fP7GNGy1LvCKW7kEjcvQ12FvSqvYdxC1kfdCz6VeDUaohQNa4S4pr4OPNUf3WZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdCT3Sa8zh6QvGLW4YC8E3cNO8031UJEzEhP1u7g2LM=;
 b=XkNDs5k74hWlHpzagqObp7knuuCdhxy1O0jK4OXIyeZYn0GH7Sd7I6L2nl+Y06/JwZDUcfDmM1JG/8cOrUTdH8291WNyrYzQtH4cdF+f37LInN9DZu3sFZp00LYXRsoIXIyZfCkAZk8WrfghEMbgaBug6j4t7xq0hoBSmJzGrFk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4190.namprd11.prod.outlook.com (20.179.151.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:11 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 06/10] dmaengine: at_hdmac: Fix deadlocks
Thread-Topic: [PATCH 06/10] dmaengine: at_hdmac: Fix deadlocks
Thread-Index: AQHV0fXYj/5vVpZ6cU+eOuaVKc1MfA==
Date:   Thu, 23 Jan 2020 14:03:11 +0000
Message-ID: <20200123140237.125799-6-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 221aabc6-2667-4a95-87db-08d7a00cfb60
x-ms-traffictypediagnostic: MN2PR11MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB41906A2818DA0AB7085D48D3F00F0@MN2PR11MB4190.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(1076003)(76116006)(91956017)(66446008)(64756008)(66476007)(66946007)(66556008)(6506007)(86362001)(107886003)(2906002)(71200400001)(8936002)(4326008)(26005)(54906003)(36756003)(316002)(2616005)(6486002)(110136005)(81156014)(5660300002)(8676002)(6512007)(186003)(478600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4190;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZypPEbolAIOzBQA35VpOpOwTqosrHbMmMzxWQ83gAJ2QdN+ZJ17LvQrBco894NM7AQf6WAysBTPYi5ojy/YSkBVFqHc861fZgX9LWVtoGTWh143JWMA5LUM0odHa6qjSdzVKSWL0HP9f9fnCtvr+jTLf5isw8DLlYzOBVqkHjlrFlmXt811kQ5Sf7SfhNkbdfL7d2MgSYWqU7FoSjPyZIt9HZ9QrYk8ONEsL2fln44qhNIUdQOlFWGCTvSeQigfmkwrv4kXmSky9HB6LFtHM4z4ghc76574179rgb/rEuYrRuDyT+7BAJbuHlkOnAempZMrmDmeIWmpmcyPiPL2t0sD+x14Tr7b2x8/JIYQ1HcjuNKORYLH9SbdGGLNOm7RKv0TjWUBKYP866ozfmrZ+HHLm7659mwnkV+FbOjmBUd9brzefgDtEj2AHcm4GVz8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 221aabc6-2667-4a95-87db-08d7a00cfb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:11.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+oelASSJP+O22YGr1inOgQWIq8TlKZmPEwIkrFGR2dnQ1IEgrbxLW7RlEtQLYCwCHNU4IdfHiyR+32JPkdthK1eU43Nt3lZDt3luZeBK+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4190
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Fix the following deadlocks:
1/ atc_handle_cyclic() and atc_chain_complete() called
dmaengine_desc_get_callback_invoke() while wrongly holding the
atchan->lock. Clients can set the callback to dmaengine_terminate_sync()
which will end up trying to get the same lock, thus a deadlock occurred.
2/ dma_run_dependencies() was called with the atchan->lock held, but the
method calls device_issue_pending() which tries to get the same lock,
and so a deadlock occurred.

The driver must not hold the lock when invoking the callback or when
running dependencies. Releasing the spinlock within a called function
before calling the callback is not a nice thing to do -> called functions
become non-atomic when called within an atomic region. Thus the lock is
now taken in the child routines whereever is needed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 74 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8e8e04bd1b28..73a20780744b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -426,17 +426,19 @@ static int atc_get_bytes_left(struct dma_chan *chan, =
dma_cookie_t cookie)
  * atc_chain_complete - finish work for one transaction chain
  * @atchan: channel we work on
  * @desc: descriptor at the head of the chain we want do complete
- *
- * Called with atchan->lock held and bh disabled */
+ */
 static void
 atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 {
 	struct dma_async_tx_descriptor	*txd =3D &desc->txd;
 	struct at_dma			*atdma =3D to_at_dma(atchan->chan_common.device);
+	unsigned long flags;
=20
 	dev_vdbg(chan2dev(&atchan->chan_common),
 		"descriptor %u complete\n", txd->cookie);
=20
+	spin_lock_irqsave(&atchan->lock, flags);
+
 	/* mark the descriptor as complete for non cyclic cases only */
 	if (!atc_chan_is_cyclic(atchan))
 		dma_cookie_complete(txd);
@@ -453,16 +455,13 @@ atc_chain_complete(struct at_dma_chan *atchan, struct=
 at_desc *desc)
 	/* move myself to free_list */
 	list_move(&desc->desc_node, &atchan->free_list);
=20
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	dma_descriptor_unmap(txd);
 	/* for cyclic transfers,
 	 * no need to replay callback function while stopping */
-	if (!atc_chan_is_cyclic(atchan)) {
-		/*
-		 * The API requires that no submissions are done from a
-		 * callback, so we don't need to drop the lock here
-		 */
+	if (!atc_chan_is_cyclic(atchan))
 		dmaengine_desc_get_callback_invoke(txd, NULL);
-	}
=20
 	dma_run_dependencies(txd);
 }
@@ -480,9 +479,12 @@ static void atc_complete_all(struct at_dma_chan *atcha=
n)
 {
 	struct at_desc *desc, *_desc;
 	LIST_HEAD(list);
+	unsigned long flags;
=20
 	dev_vdbg(chan2dev(&atchan->chan_common), "complete all\n");
=20
+	spin_lock_irqsave(&atchan->lock, flags);
+
 	/*
 	 * Submit queued descriptors ASAP, i.e. before we go through
 	 * the completed ones.
@@ -494,6 +496,8 @@ static void atc_complete_all(struct at_dma_chan *atchan=
)
 	/* empty queue list by moving descriptors (if any) to active_list */
 	list_splice_init(&atchan->queue, &atchan->active_list);
=20
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
 		atc_chain_complete(atchan, desc);
 }
@@ -501,38 +505,44 @@ static void atc_complete_all(struct at_dma_chan *atch=
an)
 /**
  * atc_advance_work - at the end of a transaction, move forward
  * @atchan: channel where the transaction ended
- *
- * Called with atchan->lock held and bh disabled
  */
 static void atc_advance_work(struct at_dma_chan *atchan)
 {
+	unsigned long flags;
+	int ret;
+
 	dev_vdbg(chan2dev(&atchan->chan_common), "advance_work\n");
=20
-	if (atc_chan_is_enabled(atchan))
+	spin_lock_irqsave(&atchan->lock, flags);
+	ret =3D atc_chan_is_enabled(atchan);
+	spin_unlock_irqrestore(&atchan->lock, flags);
+	if (ret)
 		return;
=20
 	if (list_empty(&atchan->active_list) ||
-	    list_is_singular(&atchan->active_list)) {
-		atc_complete_all(atchan);
-	} else {
-		atc_chain_complete(atchan, atc_first_active(atchan));
-		/* advance work */
-		atc_dostart(atchan, atc_first_active(atchan));
-	}
+	    list_is_singular(&atchan->active_list))
+		return atc_complete_all(atchan);
+
+	atc_chain_complete(atchan, atc_first_active(atchan));
+
+	/* advance work */
+	spin_lock_irqsave(&atchan->lock, flags);
+	atc_dostart(atchan, atc_first_active(atchan));
+	spin_unlock_irqrestore(&atchan->lock, flags);
 }
=20
=20
 /**
  * atc_handle_error - handle errors reported by DMA controller
  * @atchan: channel where error occurs
- *
- * Called with atchan->lock held and bh disabled
  */
 static void atc_handle_error(struct at_dma_chan *atchan)
 {
 	struct at_desc *bad_desc;
 	struct at_desc *child;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&atchan->lock, flags);
 	/*
 	 * The descriptor currently at the head of the active list is
 	 * broked. Since we don't have any way to report errors, we'll
@@ -564,6 +574,8 @@ static void atc_handle_error(struct at_dma_chan *atchan=
)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		atc_dump_lli(atchan, &child->lli);
=20
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	/* Pretend the descriptor completed successfully */
 	atc_chain_complete(atchan, bad_desc);
 }
@@ -571,8 +583,6 @@ static void atc_handle_error(struct at_dma_chan *atchan=
)
 /**
  * atc_handle_cyclic - at the end of a period, run callback function
  * @atchan: channel used for cyclic operations
- *
- * Called with atchan->lock held and bh disabled
  */
 static void atc_handle_cyclic(struct at_dma_chan *atchan)
 {
@@ -591,17 +601,14 @@ static void atc_handle_cyclic(struct at_dma_chan *atc=
han)
 static void atc_tasklet(unsigned long data)
 {
 	struct at_dma_chan *atchan =3D (struct at_dma_chan *)data;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&atchan->lock, flags);
 	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
-		atc_handle_error(atchan);
-	else if (atc_chan_is_cyclic(atchan))
-		atc_handle_cyclic(atchan);
-	else
-		atc_advance_work(atchan);
+		return atc_handle_error(atchan);
=20
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	if (atc_chan_is_cyclic(atchan))
+		return atc_handle_cyclic(atchan);
+
+	atc_advance_work(atchan);
 }
=20
 static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
@@ -1437,6 +1444,8 @@ static int atc_terminate_all(struct dma_chan *chan)
 	list_splice_init(&atchan->queue, &list);
 	list_splice_init(&atchan->active_list, &list);
=20
+	spin_unlock_irqrestore(&atchan->lock, flags);
+
 	/* Flush all pending and queued descriptors */
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
 		atc_chain_complete(atchan, desc);
@@ -1445,8 +1454,6 @@ static int atc_terminate_all(struct dma_chan *chan)
 	/* if channel dedicated to cyclic operations, free it */
 	clear_bit(ATC_IS_CYCLIC, &atchan->status);
=20
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
 	return 0;
 }
=20
@@ -1507,7 +1514,6 @@ atc_tx_status(struct dma_chan *chan,
 static void atc_issue_pending(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan =3D to_at_dma_chan(chan);
-	unsigned long		flags;
=20
 	dev_vdbg(chan2dev(chan), "issue_pending\n");
=20
@@ -1515,9 +1521,7 @@ static void atc_issue_pending(struct dma_chan *chan)
 	if (atc_chan_is_cyclic(atchan))
 		return;
=20
-	spin_lock_irqsave(&atchan->lock, flags);
 	atc_advance_work(atchan);
-	spin_unlock_irqrestore(&atchan->lock, flags);
 }
=20
 /**
--=20
2.23.0
