Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5159717BFB5
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 14:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFN5T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 08:57:19 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:10525
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbgCFN5S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Mar 2020 08:57:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyiy1VGSe1lGPfkBm4Axk0XcVhhey3b80OLkRdevJaIKa5HduhLYaQYNbusI8y5AJy5rlv7lnGeL13BIQMjjekoyNmBiY1Co74L5WDMtPTJ2kU0OAft0T8ZCKo8Wu3lb2DLyL4FoEGvfq3Hiz83n/C1U+ucyqMgg3ZXqukjsqLA2q1kzQcaySRutsaamCvtLIuYXqEqpIja5u25fJok1Li4Z8YUtFRmaKsY+9CnBZRA3C/ZgRGs7/8KmUIyYtWSKuRzA593Qi31nE+x4b/Szz4sE+Hbbj1UZw7qDXjNxKf+A+6l8qrysGvAWDBIDwGqHuoHLUTp6sFPVr31IgrVudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njp6jskHCe+BGI4LYaENOKy4NscQqFE+hzyhSPjQTQY=;
 b=mHrHJerVstEUnz7rPjTJuxzGX/MGpO+k2vS06lv/VE+iPr18tcwD3xgPT/sFl50Xz/ZIC+WtzCgcWNc0KNZPtr/9JBuqC1MGFlFaSj+0ne+z05peNILgFlgXaGooxt6NiosV1Uufo0hsbCcqrtsnMst7gBCp0SqaoXeygCAd83D6JfsSSOM/zXD/O5s6zJYjmxVW/XMMyYNZkwGuMcmKQF8jgLzhOJV9GRwxA+0txOSJLhaPjnlj+LAVIq0DD5AXdn4wnyzoqle6W5Ytsi5Dh7mc2YbkuTWvR1s6ZE9elopOAZ+5ZeQSrZP1ouNEOvwDwEefipWTzhfTeEPRzcfdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njp6jskHCe+BGI4LYaENOKy4NscQqFE+hzyhSPjQTQY=;
 b=HJ0m3Vb64c1QgpNK60wRKAGc6PWWiCUWNOQ718B7mxFcMylw7g4YOMXYtr9yUh185rOFT1h6j5Tda4Ira1bAejSWtR7jH96vbmPDDjoUkmRuaFrltS+6i7gZhTHM7bIEAmknya6VVgv5Az5BMsVXmtb/+AnuDv0P2b8SSFHx5oQ=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (2603:10b6:610:85::24)
 by CH2PR02MB6183.namprd02.prod.outlook.com (2603:10b6:610:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 13:57:15 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::b042:a080:e96c:5e76]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::b042:a080:e96c:5e76%6]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 13:57:15 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Sebastian von Ohr <vonohr@smaract.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV87v41lTd1EQv20WfWLzX9IzVjqg7kQjQ
Date:   Fri, 6 Mar 2020 13:57:14 +0000
Message-ID: <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <20200303130518.333-1-vonohr@smaract.com>
 <20200306133427.GG4148@vkoul-mobl>
In-Reply-To: <20200306133427.GG4148@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76c8ee99-ce5f-4ca7-3da8-08d7c1d646d4
x-ms-traffictypediagnostic: CH2PR02MB6183:|CH2PR02MB6183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB61832EA89664066A93035A9FC7E30@CH2PR02MB6183.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(9686003)(8936002)(7696005)(81166006)(55016002)(8676002)(6506007)(478600001)(4326008)(33656002)(53546011)(26005)(81156014)(316002)(2906002)(5660300002)(52536014)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(71200400001)(110136005)(186003)(6636002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6183;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJWLxou8Q3767GuAYOgNqwxHUKsVXib3AKuQHyFO91i9gx57rqbwRmTY4dXhc2BIND2Q0cQ0RjwgwM3RZTSoLWPVlrCbxLQw6AsW0FXnOrDrTcM9NV/680fPquFqmKeB886AfKqzwA1xS1TkGWqZsMmFXRd/C1ch9G3eFRsKoT5IWdDJVvfR4IV5VuoxMSc0FZjdzGN3olkNqkqPVg/c34mcdFmfoVx8MqSVLfJSP1d5c+bzW33MQsMJmwXnEhC2eBGsSQebH9Z4RTe97jUfLJLXw/slMhkgm+4OPJrIaczq4C94ziIM2alo88uxkYximjNZx3hf22dh9Nj06ih7T0FMP/XUFFsQBxCigYI5h/QqZl/BrhIQqCRGMAPxe5AI3QF/591y4tQyWD81zhx9LKql0hlEGNE1hG4RPGdwmMfQA4tZ970FK+m48Lb89Yx/
x-ms-exchange-antispam-messagedata: LdkZMy62tDEtf/Ye4GiwFG2lihJbfe+ozoZ9C8VexaGXkRmI78b4UTva0++1EwAiaLti41hRMha2rqjkx6mHmQDucPOZBGM+ZOUm+glM4FkQ6PS0TTuZCBUL4RtRc/Vcwe7bx10Kh5shG1IsPmMxdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c8ee99-ce5f-4ca7-3da8-08d7c1d646d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 13:57:14.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2ahRdZqgE5pPkU//EPADpb292zr3kiAUaoUW0IjBu6W5n7Ep8Tn6kYEJNZSaaNYGKKu/go+Le81eYtDcf/wOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6183
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, March 6, 2020 7:04 PM
> To: Sebastian von Ohr <vonohr@smaract.com>; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>;
> Michal Simek <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: Re: [PATCH] dmaengine: xilinx_dma: Add missing check for empty l=
ist

Minor nit -  Better to also add <...> "in device_tx_status callback "
>=20
> On 03-03-20, 14:05, Sebastian von Ohr wrote:
> > The DMA transfer might finish just after checking the state with
> > dma_cookie_status, but before the lock is acquired. Not checking for
> > an empty list in xilinx_dma_tx_status may result in reading random
> > data or data corruption when desc is written to. This can be reliably
> > triggered by using dma_sync_wait to wait for DMA completion.
>=20
> Appana, Radhey can you please test this..?

Sure, we will test it. Changes look fine.  Though had a question in mind,=20
for a generic fix to this problem, should we make locking mandatory for=20
all cookie helper functions? Or is there any limitation?

The framework say for dma_cookie_status says locking is not required. This
scenario is a race condition when the driver calls dma_cookie_status and
it sees it's not completed, but then since there is no locking and dma=20
completion comes and it changes cookie state and removes the element=20
from active list to done list.  When driver access it in tx_status it  resu=
lts
in data corruption/crash.
>=20
> >
> > Signed-off-by: Sebastian von Ohr <vonohr@smaract.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index a9c5d5cc9f2b..5d5f1d0ce16c
> > 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1229,16 +1229,16 @@ static enum dma_status
> xilinx_dma_tx_status(struct dma_chan *dchan,
> >  		return ret;
> >
> >  	spin_lock_irqsave(&chan->lock, flags);
> > -
> > -	desc =3D list_last_entry(&chan->active_list,
> > -			       struct xilinx_dma_tx_descriptor, node);
> > -	/*
> > -	 * VDMA and simple mode do not support residue reporting, so the
> > -	 * residue field will always be 0.
> > -	 */
> > -	if (chan->has_sg && chan->xdev->dma_config->dmatype !=3D
> XDMA_TYPE_VDMA)
> > -		residue =3D xilinx_dma_get_residue(chan, desc);
> > -
> > +	if (!list_empty(&chan->active_list)) {
> > +		desc =3D list_last_entry(&chan->active_list,
> > +				       struct xilinx_dma_tx_descriptor, node);
> > +		/*
> > +		 * VDMA and simple mode do not support residue reporting,
> so the
> > +		 * residue field will always be 0.
> > +		 */
> > +		if (chan->has_sg && chan->xdev->dma_config->dmatype !=3D
> XDMA_TYPE_VDMA)
> > +			residue =3D xilinx_dma_get_residue(chan, desc);
> > +	}
> >  	spin_unlock_irqrestore(&chan->lock, flags);
> >
> >  	dma_set_residue(txstate, residue);
> > --
> > 2.17.1
>=20
> --
> ~Vinod
