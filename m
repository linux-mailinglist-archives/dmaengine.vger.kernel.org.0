Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F3146AA5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAWODK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:10 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22605 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWODJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:09 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: MVlLb011WR/QnrsRxQyrxH6AjLH+RzS7Opy2xPIMJRZCOLSX/71JVAXbeBEFARep6lgjDOL0x/
 UnUKFnp8DTFWPQg25Bq5VtbePJKKB6hlRNVz14FwwDknD3wy9oJFAn8Qph+Cptt1LHXZUbACLF
 jSXaH3Obz5VIoxFr/o9K9eTQECk5pl5LmnW+5osSHTX9JQIzE2Sk00aiGiQXwzxRu6bymJVyFc
 2sozyBocxMyC/6jELUToAkEaCJWaploqeYUkKNWgcc+TnLqF6yQbdvYNoOC+JFKCwjWqg0NraV
 /BU=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="62879870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 07:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0MY3m1pkTG4sUO7rGl+WPtBxpHpbzR4GhRO75mOimHUN8ELkhyz8g3b5jfTN66msIZ13cKREOsvFkVEUAIXrHoxpiNlbJr+AN9lmYtxiUwNjmvWbRfMLkVoirhgUws5a8E2uUqckj7SpQiC/X/crB7MrMfVtQyMUX6cawffz5rLpbb5yLh2V2jyiVVX5l7cFUnZw/SxwBlS+PWh81rsjaqJREoddjVl9lueP2NjWoWeKyAT8FB6YCULOkupLLRQrw29n+ou1Til7I7dcR67ReKFWrRrtzSu+KQJB1qsA72Ujk3VE7tRwlBdTy1xdmy2ca3jx8A4ADNID2SuQtw0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYDvGJfouxDU0Z58xGfTrYTQ+HZSeWJge9En2L7cxOo=;
 b=j9Eflh+Qk7tx3qP4Bke7Dewyn83iKD4YVLJeu/tR/3DElu5HXVzuiNobykTXuNygNo/GbJ4J1DNBsFhu+N4/VgihWAf7zdrFumyDr4AgcMUMEKIRwvYYos+fMXkutMqeYQ49elV0MZn+PagbTrp0UBcdUDObdQ+AW7AsJmSwppyjMU63o8eXdu3Vid6SDieRdJDJQYT7+wmqXf1cIabu3ROuayYeSEx40WI7qxnfCXED103xQwf7MN2rE9mm8QQeLHOxw1LCZsNQctkCw9HaSH6pCX63FB+/RN/qeCw0f406ik+vak51UbMnRrdA+wzkf/JdMtFTmg85x2D+wVgbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYDvGJfouxDU0Z58xGfTrYTQ+HZSeWJge9En2L7cxOo=;
 b=S45CRwbWUCiHH6o9QefwUWsrBsPuIA4E/ki/567SR+TZLNDCwn+92u8qNjnKnoDsTx+97uY3WUyLOb7tZWeDnFG041Hjw7J3IVqX0gJhD1r8WGeVP0q6Yk3K8AyFoHEKa81Q72ZC4M/HlLmlxyCJiP+ZSCQHBYiG2i8dZsGq7x0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:06 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 03/10] dmaengine: at_hdmac: Return err in case the chan is not
 free at alloc res time
Thread-Topic: [PATCH 03/10] dmaengine: at_hdmac: Return err in case the chan
 is not free at alloc res time
Thread-Index: AQHV0fXVjTs4Wc6BRE650oM1XaQZzg==
Date:   Thu, 23 Jan 2020 14:03:06 +0000
Message-ID: <20200123140237.125799-3-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bbcb102-18b2-41cf-6a23-08d7a00cf855
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB35823E121071D89022560AA9F00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEVR3Qs9Wf8L8kgoXTZ6kUn/1o+2ZCDHoA+vhHTVa1/i+KE6pRv4N+payYFB7u7onq8PY767epHg2fiUmlKIJgc4IxiCtmZPlT4ITLYFWhlUemgXo215Q/yqWmy6pVUc6TBIzS4df0gcfP2v1k0WOzhiVtUWJ3if7oRjqfSrcbGXe9tEZ4Nqqthn1ryGck2sehVPk9++nIScer0xVNXZ9hyc5MFJl5R05OUm0gP4HnL1br68WN5G3I7Urw+cWMJBJyUuNbUDdVzBOeJwKdRmX/5Kc4JU+KTSa/cQu45Yfe84RXjFiFJremEgvsccSwM7oFcZvy+agG1Xf8xeaVBbZhTa7jZDeMPZcWhEvDk+jv2mKkhTdtRwuadXxtssQuNmaHbcS/up9fL6pLuwEqaZkKDO9EGKdoCzrHP8u9NxgkW2jA3lNo3SsyXQ2TRhAJWJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbcb102-18b2-41cf-6a23-08d7a00cf855
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:06.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOcG1JZheLYRtZCH7P2qATA4/HQQIxkTUJKopgsogksonSzuG6RnEk1Gr8aUBOwANQ4kwNsti6tUuX2+LSdNLJL5WqO9Y4nzNixPQdA9gR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Having a list of descriptors allocated for the channel at
device_alloc_chan_resources() time is a sign for bad free usage.
Return err and add a debug message in case the channel is not
free from a previous use.

atchan->descs_allocated becomes useless, get rid of it. More,
drop the error message in atc_desc_get() because now it would
introduce an extra if statement. The callers of atc_desc_get()
already print error messages in case the callee fails, no one
is hurt.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c      | 31 ++++++++-----------------------
 drivers/dma/at_hdmac_regs.h |  2 --
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 301bae45cf8d..e17b75075904 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -146,17 +146,8 @@ static struct at_desc *atc_desc_get(struct at_dma_chan=
 *atchan)
 		"scanned %u descriptors on freelist\n", i);
=20
 	/* no more descriptor available in initial pool: create one more */
-	if (!ret) {
+	if (!ret)
 		ret =3D atc_alloc_descriptor(&atchan->chan_common, GFP_ATOMIC);
-		if (ret) {
-			spin_lock_irqsave(&atchan->lock, flags);
-			atchan->descs_allocated++;
-			spin_unlock_irqrestore(&atchan->lock, flags);
-		} else {
-			dev_err(chan2dev(&atchan->chan_common),
-					"not enough descriptors available\n");
-		}
-	}
=20
 	return ret;
 }
@@ -1553,6 +1544,11 @@ static int atc_alloc_chan_resources(struct dma_chan =
*chan)
 		return -EIO;
 	}
=20
+	if (!list_empty(&atchan->free_list)) {
+		dev_dbg(chan2dev(chan), "can't allocate channel resources (channel not f=
reed from a previous use)\n");
+		return -EIO;
+	}
+
 	cfg =3D ATC_DEFAULT_CFG;
=20
 	atslave =3D chan->private;
@@ -1568,11 +1564,6 @@ static int atc_alloc_chan_resources(struct dma_chan =
*chan)
 			cfg =3D atslave->cfg;
 	}
=20
-	/* have we already been set up?
-	 * reconfigure channel but no need to reallocate descriptors */
-	if (!list_empty(&atchan->free_list))
-		return atchan->descs_allocated;
-
 	/* Allocate initial pool of descriptors */
 	for (i =3D 0; i < init_nr_desc_per_channel; i++) {
 		desc =3D atc_alloc_descriptor(chan, GFP_KERNEL);
@@ -1584,17 +1575,15 @@ static int atc_alloc_chan_resources(struct dma_chan=
 *chan)
 		list_add_tail(&desc->desc_node, &atchan->free_list);
 	}
=20
-	atchan->descs_allocated =3D i;
 	dma_cookie_init(chan);
=20
 	/* channel parameters */
 	channel_writel(atchan, CFG, cfg);
=20
 	dev_dbg(chan2dev(chan),
-		"alloc_chan_resources: allocated %d descriptors\n",
-		atchan->descs_allocated);
+		"alloc_chan_resources: allocated %d descriptors\n", i);
=20
-	return atchan->descs_allocated;
+	return i;
 }
=20
 /**
@@ -1608,9 +1597,6 @@ static void atc_free_chan_resources(struct dma_chan *=
chan)
 	struct at_desc		*desc, *_desc;
 	LIST_HEAD(list);
=20
-	dev_dbg(chan2dev(chan), "free_chan_resources: (descs allocated=3D%u)\n",
-		atchan->descs_allocated);
-
 	/* ASSERT:  channel is idle */
 	BUG_ON(!list_empty(&atchan->active_list));
 	BUG_ON(!list_empty(&atchan->queue));
@@ -1623,7 +1609,6 @@ static void atc_free_chan_resources(struct dma_chan *=
chan)
 		dma_pool_free(atdma->dma_desc_pool, desc, desc->txd.phys);
 	}
 	list_splice_init(&atchan->free_list, &list);
-	atchan->descs_allocated =3D 0;
 	atchan->status =3D 0;
=20
 	/*
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index fe8a5853ec49..397692e937b3 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -243,7 +243,6 @@ enum atc_status {
  * @active_list: list of descriptors dmaengine is being running on
  * @queue: list of descriptors ready to be submitted to engine
  * @free_list: list of descriptors usable by the channel
- * @descs_allocated: records the actual size of the descriptor pool
  */
 struct at_dma_chan {
 	struct dma_chan		chan_common;
@@ -264,7 +263,6 @@ struct at_dma_chan {
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
-	unsigned int		descs_allocated;
 };
=20
 #define	channel_readl(atchan, name) \
--=20
2.23.0
