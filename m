Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1B146AB5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWODc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:32 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:5788 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgAWODX (ORCPT
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
IronPort-SDR: +SuwJ2geEPTUVyfVVC8KY4h+0BM5fjoSWH97sqqwARGIna/CVqhpIyTOPqEzBc6KaAOsZjo6M7
 1+SIY851hqSZ3n77C/6a6jNwppuNvbBF2P0cYGAoE14DMg8AyLv4vEPXDoGjVwPrvIlMdfN/OR
 mTuKFSKvpqaxrIM3EAe7tTLVJofjUBmGX4igsFnWxnNiD1vf1oKeSJvXcbmKsoCUy3Ydf8QwK0
 5cC7lTkeHK/kjOP6UFY/McPgGnIakW4ZwQYbo2b7ykt2yiU+R55vIjnZzZ05ypTbG3tHVLKNst
 HIs=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="63527843"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 07:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcRqky0Ij3bxRq1bHLtDWTek7+zS3q8Yvq21pbK4QSLnPkDbyZIqpGGbVJlPfRGMJSV+Ng+BMH0eN4hJomvh8l+t/N7/8LIsr/9k4w+r6aZlHoPQJlEWvIIR0uXTcYoDvrWLRDJWVCz+vrSOAYjJFnIiX0C1jHb89zYkVsRnGkNoQkXbRYEbv1sUI/WDncT7Z4Bg8fgCy2uUI+jZVwG+K5ExKsw2lgF6bic+fywpkkY7hJUYUVtj5wY4UTdM4Gu/aB/QUTYRKhsW+jFeAk3bpTwjLbrztuqodOi2N/ycPbhHDRRBdGVoSGwtXAIuC9oLNk5vAyS6lA3gAS/uFyWb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1+h7dVbV6KuHmrHlLYHbEDUOaXx+4BA6QBHOz5of6s=;
 b=P/6+bM1URAguUfpbHg63FXUbQ3Y9EJUe5uwPLTduIymWkRfVCqwdQAjkmdb6OoYEv1iXVdMjzafE21NpGYY8PwJ3t1mRkT0yQ4m/65DDCdWvmFaX0rRlrYvY4vpL4Zh4pT1sq1ja49c9OW1rVg7TrIstIZzOmD8W55Jk9MIS0gtwo6ibUolRY2YiEdl7exQg2jMJDe74m5wVjOFfIkSQPmOQ3kUfioQcT4Ih/rYLHjHlUHKV4iz91ERxB47vScZb9Y4MywgK/2Z/kXO38c7wiG0poc2cI29BDTAv/jDk9qQrdAIG5wVhIYwVt3zPwTvYk06MCmY3GzaeMDGW5sSBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1+h7dVbV6KuHmrHlLYHbEDUOaXx+4BA6QBHOz5of6s=;
 b=hVcEXG3R7nbEY+eMYflWKeOUcyKhdgFsIJ2zG9ktn+wdxbYedB0y0mpBT/Hgogb8BNIVNX440aJKU8z3ld9z/owsHwoQ+v1AzxS+88dziNz0zsP9Dr/oTamUmmAtjZpVkOXwokbtVyl48kup4RtoizHs4VuA9efVPfpu7pEU3Ss=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 10/10] dmaengine: at_xdmac: Fix locking in tasklet
Thread-Topic: [PATCH 10/10] dmaengine: at_xdmac: Fix locking in tasklet
Thread-Index: AQHV0fXcFbXcnKYrSE6o/6h9ErutqQ==
Date:   Thu, 23 Jan 2020 14:03:17 +0000
Message-ID: <20200123140237.125799-10-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a3c654-dff5-46b4-a5ea-08d7a00cff19
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB35824D1818AECB0349A7F050F00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0MeQXV5t/KeNsFuI0nFbSadcwVttu+dleXDuGvlBLdr5hvurQ4Rg6PHpaBUW4XdGi/NVpnzknSYP8XrwO0yIseGXp2+jiKEZvrxcI9NPBIbdGhl9//sHDO7GwZ2onS3RJfp0whxX0H5/PJj2Ks6aWfMKzmHvTJj8kbbK/I6N22cdTyNYpRqWIzMni8YOoRvP9pDXuYtb/wdV+ByB1wS+zrd3/VoFE3hzhXmS1tJ3APQ5D+M/ELK1Bdw5qcjFlZTDX21LuXN7nLHMtIalOTUgk5D+8YDCPAhOScMBO+TFNAIF+wr2m5lKtfxco3Tt84kK5wNYQdEZOt+XOCSYlBhk5PcHOMuvVplkrW1b6gkbQ6BEL6s35zdeKg8Ek0FktJ+nsE+FVCeTM39GkfOzkrrTZcuuaAwUhGpByRNpR/1kmAgYnC5m+vM14YRxuRbTysTL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a3c654-dff5-46b4-a5ea-08d7a00cff19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:17.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDbFX3kxyhUtvGuA8qjKOsg86eD7lar57HuUi4TZd464wildMXcfUm/68Z3itpKUB0c1GfMOie0U88zuxLL5f7ACnmTHPvvAQk8/eO4b9w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Tasklets run with all the interrupts enabled. This means that we should
replace all the (already present) spin_lock_irqsave() uses in the tasklet
with spin_lock_irq() to protect being interrupted by a IRQ which tries
to get the same lock (via calls to device_prep_dma_* for example).

spin_lock and spin_lock_bh in tasklets are not enough to protect from IRQs,
update these to spin_lock_irq().

at_xdmac_advance_work() can be called with all the interrupts enabled (when
called from tasklet), or with interrupts disabled (when called from
at_xdmac_issue_pending). Move the locking in the callers to be able to use
spin_lock_irq() and spin_lock_irqsave() for these cases.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 31321da69ae6..bb0eaf38b594 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1543,9 +1543,6 @@ static void at_xdmac_remove_xfer(struct at_xdmac_chan=
 *atchan,
 static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac_desc	*desc;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&atchan->lock, flags);
=20
 	/*
 	 * If channel is enabled, do nothing, advance_work will be triggered
@@ -1559,8 +1556,6 @@ static void at_xdmac_advance_work(struct at_xdmac_cha=
n *atchan)
 		if (!desc->active_xfer)
 			at_xdmac_start_xfer(atchan, desc);
 	}
-
-	spin_unlock_irqrestore(&atchan->lock, flags);
 }
=20
 static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
@@ -1596,7 +1591,7 @@ static void at_xdmac_handle_error(struct at_xdmac_cha=
n *atchan)
 	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
=20
-	spin_lock_bh(&atchan->lock);
+	spin_lock_irq(&atchan->lock);
=20
 	/* Channel must be disabled first as it's not done automatically */
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
@@ -1607,7 +1602,7 @@ static void at_xdmac_handle_error(struct at_xdmac_cha=
n *atchan)
 				    struct at_xdmac_desc,
 				    xfer_node);
=20
-	spin_unlock_bh(&atchan->lock);
+	spin_unlock_irq(&atchan->lock);
=20
 	/* Print bad descriptor's details if needed */
 	dev_dbg(chan2dev(&atchan->chan),
@@ -1640,21 +1635,21 @@ static void at_xdmac_tasklet(unsigned long data)
 		if (atchan->irq_status & error_mask)
 			at_xdmac_handle_error(atchan);
=20
-		spin_lock(&atchan->lock);
+		spin_lock_irq(&atchan->lock);
 		desc =3D list_first_entry(&atchan->xfers_list,
 					struct at_xdmac_desc,
 					xfer_node);
 		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
 		if (!desc->active_xfer) {
 			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
-			spin_unlock(&atchan->lock);
+			spin_unlock_irq(&atchan->lock);
 			return;
 		}
=20
 		txd =3D &desc->tx_dma_desc;
=20
 		at_xdmac_remove_xfer(atchan, desc);
-		spin_unlock(&atchan->lock);
+		spin_unlock_irq(&atchan->lock);
=20
 		dma_cookie_complete(txd);
 		if (txd->flags & DMA_PREP_INTERRUPT)
@@ -1662,7 +1657,9 @@ static void at_xdmac_tasklet(unsigned long data)
=20
 		dma_run_dependencies(txd);
=20
+		spin_lock_irq(&atchan->lock);
 		at_xdmac_advance_work(atchan);
+		spin_unlock_irq(&atchan->lock);
 	}
 }
=20
@@ -1723,11 +1720,15 @@ static irqreturn_t at_xdmac_interrupt(int irq, void=
 *dev_id)
 static void at_xdmac_issue_pending(struct dma_chan *chan)
 {
 	struct at_xdmac_chan *atchan =3D to_at_xdmac_chan(chan);
+	unsigned long flags;
=20
 	dev_dbg(chan2dev(&atchan->chan), "%s\n", __func__);
=20
-	if (!at_xdmac_chan_is_cyclic(atchan))
+	if (!at_xdmac_chan_is_cyclic(atchan)) {
+		spin_lock_irqsave(&atchan->lock, flags);
 		at_xdmac_advance_work(atchan);
+		spin_unlock_irqrestore(&atchan->lock, flags);
+	}
=20
 	return;
 }
--=20
2.23.0
