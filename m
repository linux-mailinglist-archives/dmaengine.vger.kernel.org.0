Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E281F1FDAA1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFRA4G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 20:56:06 -0400
Received: from mail-eopbgr1310109.outbound.protection.outlook.com ([40.107.131.109]:50176
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgFRA4G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 20:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGupuI8XKysuHhT3vynODNFd96KjqfRwyceCY8P/OLteAqYY0sCIetq5/DK4Z7TOXtXfxIpcwNJs5omDJiXi3HcQaSbpYrTlcAhxBg/BIjY89DUUstJv/FrbTwNe4/7Et9b1YtnQLl6lPwFw0vBvVdUXX5jimjSOiSkIBvRDBEY0JBDbxVZkrrUw0Jy4nfI/qWDdnkcajy+EOM0WMj+FmWJ9DqTigmg/76kxoKWqr1YkRNeo8DGFx2U2YZeeVtTkJmf8SmJkz7J+hhu1JnXwyfdrjeh/44A7d0Y/7M95VHvWzXG6pHWEIwirA1HgzrOb/j0UAJ8QQgPLiP6LITJD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JM/LHZsnYmOEuh1YZwQbw90FKmlEIQl5NiDJXxm96w=;
 b=VaUcrhmaIhD1Mmg1eKMrxAKBFRqGhh5PlsmiuYb0bqPRxO0fhRpp3H+kU3O93GduQIsT7Ud10hft5zT/QAiIcCYykRzCqk1cWCKd8T2NQb+EkdNbKihePzEzP/uRcjW6hZ/k9NoO498twItT7UsfSi9DyAyR/vme08wrBj/+Fwe4QAju6mqTidurZaRgo9PMe9GbZKbnbtZrAdbfOsXAaJ4BKHQ7rZMQeA/WZM0XYX7crohUJy+1EMxTWWqA4KlpV5Kk2vbh2o0t3Hmg217SLttQj61zhMUYdvm/Qn7ryQNueO4/6gX53Ll1i00Snk+ucOo8W+B6Vt6eWoLEWtJQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JM/LHZsnYmOEuh1YZwQbw90FKmlEIQl5NiDJXxm96w=;
 b=qaQdl4xPo+umXKg362TKT4t2tUOY3s8NMOB4qGDStCJG4dEY7DxcswPpI8Ydk6SREJlMyixL4tdgt1838SiCEZVBBjmK1mvBrwSYlwwIpYfCSIPmFDgjkafnaQVo56fJkOKCDbM3BgA/SznubB/ckNfWlIE1jskv7VRKKcRGfAY=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4603.jpnprd01.prod.outlook.com (2603:1096:404:10f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 00:56:01 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 00:56:01 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Thread-Topic: [PATCH] dma: sh: usb-dmac: Fix residue after the commit
 24461d9792c2
Thread-Index: AQHWL2V2RkH5colCb0+zPor5o0eqOajbny8AgAIVYeA=
Date:   Thu, 18 Jun 2020 00:56:01 +0000
Message-ID: <TY2PR01MB3692283C5F3695033D20A7AFD89B0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1590061573-12576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20200616165550.GP2324254@vkoul-mobl>
In-Reply-To: <20200616165550.GP2324254@vkoul-mobl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 719b806d-a21a-4c6b-fe5b-08d813225ed3
x-ms-traffictypediagnostic: TY2PR01MB4603:
x-microsoft-antispam-prvs: <TY2PR01MB46037162E609B90D41806BE6D89B0@TY2PR01MB4603.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JrIyl1Je40WKwvPAqkbXASVrtfmhVIqxVwmmnlb6Fwv1pq4lYx+nG7mp2DYgQb1buUNP+QvH63dHqSONMSBgrcXLRzmWEjxBK5GmX0bfs5v99RLnxsp3boKKYpxj+tocV6b3kdZRS+8tev4o/uIehxxtvE51mltDLe1o2gKwlZCo8Q26GwUlPpggcS7QdzURC4rle9YXBMmSTDDjsyFc6pwZR1pQSa4Nf+8DyEdC7lvK+/4+pYLi1z4NTzDtjE3pgNs2eLtU7h+nlvIrsHxJhmbghNqYJPxxDBdhE2vhEjMcJ7uN9EXOZiwzvOOV17A8R6zM1Tnx6WoJItUrlF6s2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(54906003)(478600001)(55016002)(8936002)(6916009)(8676002)(66446008)(64756008)(316002)(2906002)(33656002)(4326008)(66476007)(5660300002)(71200400001)(66556008)(26005)(66946007)(186003)(6506007)(53546011)(86362001)(76116006)(83380400001)(9686003)(55236004)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V3o4Tr5msD0Lba0WcNChP3MJPc32P9rAo4e3rJl+FAq2DBw+GxtSCJVsgqhhP0mrcWkGYbWzlzadtuFAzEImzY8MaVljyyFv/U/ZC8XPFWvBS3AkEpARBnBjJnTd4Rpb+Y3H7Ml0YO/vniX2XYR8D5Qnhh610BdwMjLGQkvQ75ClNEDsHMtzKnFawBeTox8QvwJfrkSkgZ3u0LhWdAGQvFX3JP2JvG6Qw6U1wltLXFub5DkZT6icQEXOoAoDy0sFshOWGaqXlFuVYxONVooBKQfKNsriE0C58pzx9k074dVCPoqBBxdaHmqG4lvUsfsd+duzd9LBeFaNK4TgJdUP89eWqtgNS5PUl2uFHlkQqLbz1fNf75eUSzx1tWlie2YKB8EC+Z//hfz/A9Kg2lr+ho7x7f9uT7VPMxX8eDGbp5MkxVZDJTZoIOojWQLq+r2wsbaGb+7ZCEtYGdugqkITCZsjAoSOnS58P6oezECl3kwaPFG8OKezRnnqLCy/l4QP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719b806d-a21a-4c6b-fe5b-08d813225ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 00:56:01.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtoTB3iD/wy5dOGPFpRQZgeGMRjgY1iQ8VgFJJwp4NGspEjHLqXogDPvqjYqU46w5xIzX7X022zIzA5o338pZJy8ih9Gm92PGMkrypJ/yXm0wL48xO9c7dXUfK2mCWhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4603
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> From: Vinod Koul, Sent: Wednesday, June 17, 2020 1:56 AM
>=20
> On 21-05-20, 20:46, Yoshihiro Shimoda wrote:
> > This driver assumed that freed descriptors have "done_cookie".
> > But, after the commit 24461d9792c2 ("dmaengine: virt-dma: Fix
> > access after free in vchan_complete()"), since the desc is freed
> > after callback function was called, this driver could not
> > match any done_cookie when a client driver (renesas_usbhs driver)
> > calls dmaengine_tx_status() in the callback function.
>=20
> Hmmm, I am not sure about this, why should we try to match! cookie is
> monotonically increasing number so if you see that current cookie
> completed is > requested you should return DMA_COMPLETE

The reason is this hardware is possible to stop the transfer even if
all transfer length is not received. This is related to one of USB
specification which allows to stop when getting a short packet.
So, a client driver has to get residue even if DMA_COMPLETE.

> The below case of checking residue should not even get executed

I see...
So, I'm thinking the current implementation was a tricky because we didn't
have dma_async_tx_callback_result when I wrote this usb-dmac driver.
I'll try this to fix the issue.

Best regards,
Yoshihiro Shimoda

> > So, add to check both descriptor types (freed and got) to fix
> > the issue.
> >
> > Reported-by: Hien Dang <hien.dang.eb@renesas.com>
> > Fixes: 24461d9792c2 ("dmaengine: virt-dma: Fix access after free in vch=
an_complete()")
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/dma/sh/usb-dmac.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> > index b218a01..c0adc1c8 100644
> > --- a/drivers/dma/sh/usb-dmac.c
> > +++ b/drivers/dma/sh/usb-dmac.c
> > @@ -488,16 +488,17 @@ static u32 usb_dmac_chan_get_residue_if_complete(=
struct usb_dmac_chan *chan,
> >  						 dma_cookie_t cookie)
> >  {
> >  	struct usb_dmac_desc *desc;
> > -	u32 residue =3D 0;
> >
> > +	list_for_each_entry_reverse(desc, &chan->desc_got, node) {
> > +		if (desc->done_cookie =3D=3D cookie)
> > +			return desc->residue;
> > +	}
> >  	list_for_each_entry_reverse(desc, &chan->desc_freed, node) {
> > -		if (desc->done_cookie =3D=3D cookie) {
> > -			residue =3D desc->residue;
> > -			break;
> > -		}
> > +		if (desc->done_cookie =3D=3D cookie)
> > +			return desc->residue;
> >  	}
> >
> > -	return residue;
> > +	return 0;
> >  }
> >
> >  static u32 usb_dmac_chan_get_residue(struct usb_dmac_chan *chan,
> > --
> > 2.7.4
>=20
> --
> ~Vinod
