Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E287AE663
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjIZHEg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 03:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjIZHEe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 03:04:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839FA10A;
        Tue, 26 Sep 2023 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695711865; x=1727247865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rtEW6AO5hwCWhiHnzUHbbFna6HUhXa2yvivhpQDMlOM=;
  b=xAhCdMwnjVTV3ATRor+8X/JoHe59fIWGz+T4QUOsTO3nOrlLpJNbprKq
   H5HHX21k8xlysWDNp3EUiCJC8ia8TgDPzSDBE8nQffTF8ambuKQ5rV/py
   lWG6I02CCuDg+ofcjoV30+nc1bnqdHKnbUfDt9g71ijgjimEE/cz4Qwme
   Y6bsJlylKNj6Do0ufcnMq5yJQI29ctq0UCm3C2t1lC9q05BXTuI4ZMzVu
   E8y/IYd4wQjCUIarRWnodipFq7Kdcehk3XG82oRYp7pARwuBXYuPbb1hK
   HH9DpsOMa30iKa4CZQ9syH8otpxFk6S3rmui+DujZUAv6NPq36UXq6AM8
   A==;
X-CSE-ConnectionGUID: Cr+eQmHrRSep5KdykVKK0g==
X-CSE-MsgGUID: srHzkV6KTde0B/j5aSyqNg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="6842733"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 00:04:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 00:04:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 26 Sep 2023 00:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dODSR2/VX7ccwgrPlBuri3IGd0mlycTxNgpEFUsdV5L5RQb4oqkaLbVF4ueyYFvurrUIgbK6ICrI8XQqMCHl9QLemQBAVDb8KmdF246jP3uY9sjnksv4GLETueS4trjNpNK3itD6I1Zz/OeVp7HWnd+843OD7DqDsVurHDAa65e/40LhzWXum+QEnikAXFGGyJt/PV8Cv/Us4JhXCEstkN69PW8VXqEXxjknGiwXNU8k2m2m58NxfreklX5LRsmulSQjH7/PTm8njeUJ1bRJGjVBjpnvWfDiG93X2FhX8MhVhnNytTM9v4iARBJY6exycDlTOoBTkxaeShxYW9x7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwyk6FS6hdZ/u3PfsLvXPYQBP8H7lwuU5CSPj2Mz6Js=;
 b=WrNpwLZaOz/aqACFx7vAgXX19+WidgZ9YAWlyBRyUTH6CGkXyXbOGE/xKigSS8Hx5z6AtWdK8EleMbrgRq2g85Nad+KHV6zQlfMS5uN0UKCIYTyRDyj2gr2MYt3fAdsl/+QtJUuDToeFKm8nVHPf/ERDFhqlsA7KHYJ8bHLdqsck9l/FPpTeSZKmlJskeLBrtFKT3e/wkN4CuMjntsH/46xvVVzHPBCRMaIU889567ZUfW+3GRznBX7E2SNV7i32OJyR9AGAvi1ijkbexd9Q7TWrs6TnocSlHvRm7GnFnVOY6AIZb3qi3VKYeDGRPsF6bEnkz8iKXqYsVgs7d9xoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwyk6FS6hdZ/u3PfsLvXPYQBP8H7lwuU5CSPj2Mz6Js=;
 b=kXWgm1rkW6fzWPtPghA2d9/jlPGpKa8fUuY4oLuL92yoedAvvzoNKTXx4R0vBAS1TRbLcxmOzimnHn2OGfL2JpjJUn9LiBeug0PL7ohTdR5wP2MmQrL45MnWq4obvJe+GuCzK8Gcn01h5JtWOfVdDIEXqeXt/aY62MpVmQiHerw=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 26 Sep
 2023 07:04:22 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 07:04:22 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <conor@kernel.org>
CC:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
        <palmer@sifive.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nagasuresh.Relli@microchip.com>,
        <Praveen.Kumar@microchip.com>, <Conor.Dooley@microchip.com>
Subject: RE: [PATCH v1 3/3] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Topic: [PATCH v1 3/3] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Index: AQHZ7TpYtoHe5V6jCkaV0cVSgcPUurAmncAAgAYXIuA=
Date:   Tue, 26 Sep 2023 07:04:22 +0000
Message-ID: <PH0PR11MB561107915309A4108EF0DC9B81C3A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230922095039.74878-1-shravan.chippa@microchip.com>
 <20230922095039.74878-4-shravan.chippa@microchip.com>
 <20230922-sappy-huddle-1484d64b27f3@spud>
In-Reply-To: <20230922-sappy-huddle-1484d64b27f3@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: ef541a20-f3b8-4ca3-67df-08dbbe5ecfa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fjo8JrICqfHNpvLlpq8JCG+yJfqFwKkKfkv6uk7eQG+Y77gWRQaFcMhonJqlwrgu+xtRgEWtChAuvcnLeZ5OWhLJeg3iur1x4xg6pdWurpr+qUm3nfGiUDK31ex5NvZnaNtNu3nZLrwohL85R3N/sxUS2SiTqG6g2uhP2JuhstGz8HFEo27PTyJy8olN9I0xoNoX67wBM7PGPPvvCK01YOm4djo+wWmztg4uFPxJ796HFw0RTKHXCzKwvijV1tS5cUFJ12p5tRVGnGy0cnqbT15yLLbGOb02M4EdPDe+0jgNAUjXL3zn45751bIPkZCljAvCuH8CpG0DYIVc7lKFt/79DSjH1akPLJSHBKROfP0xNvlUx9CO8X6YeX9N1mEa1YqPjIoip9Tz4xNCzLCSVQlrZ2y2LgpYgmctm1Fa3uFs1r9gsyGw2Av8H7bxbJ3Ghinl44RJLfUIUtNGlvfYgSv9Xhwp9NwiTHYhJui6R1DCRyohCoy+KUPW4LweURA3hATimnwD80RoPFTiISCXXl3V3rcXyNJXGZBqSmQfTsZmTSeS0gVQlRj4biLt831Qr7CyfHdR16aHocCISexBJOWj1F8VXXYftDjheInG7+YX8+/R4HwCZjzqr1kceESw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(2906002)(7416002)(33656002)(86362001)(55016003)(5660300002)(38070700005)(38100700002)(122000001)(52536014)(8936002)(8676002)(4326008)(83380400001)(41300700001)(6916009)(316002)(107886003)(66476007)(26005)(66446008)(54906003)(53546011)(66946007)(66556008)(9686003)(64756008)(71200400001)(6506007)(478600001)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnKEU6BK0D5jSKMDSmqMwuJfIfP8Cvqrzqisb8y59MPDbJAvP+Dyy+ch66tg?=
 =?us-ascii?Q?3nxvZbjF/NTi+jeKTJL2e9Dv5omAdL64GOMhLcknFwqRBwQw2tOufxuIFKfK?=
 =?us-ascii?Q?VA00d3D9epgCQ0+9m3922++hhqT1bxAlB3xYyIgQ1xS4NnZj1CCSSloEE+0r?=
 =?us-ascii?Q?JiJgEpB0pMXfodWn45/Haj8kv9qmUc1Fj0o7YPj9ZyYPOVnfWgvRhnLErU0q?=
 =?us-ascii?Q?YZ0TZe6XCkDb090R8TCdPVRn+L7Y8JluRmJRiX3kGtx/htBa0c040LxtR9Zc?=
 =?us-ascii?Q?9397wiVrawiunGt4YmeaEmbynC2WYqvKZQt0l4Oo1bqwUciyzusZAE6z/qym?=
 =?us-ascii?Q?1OfGiF5Vshr9Hzt0Ab+3IZT5jy1QOzPRUCkad/+qrC8+o0su0wDdE/mgOi46?=
 =?us-ascii?Q?YbYI1IXgMG3ImkqRgd0WNRZHpLP2f2+m2seIuBRr7pjbryJNt7mf2CBK46uh?=
 =?us-ascii?Q?OIyPkum+uSvYo3T9ERlvce/tySxTFvuEQsiJ8royBSbCCD4siMF8C7+mhpqU?=
 =?us-ascii?Q?D3LmIjaZTF9E/wp/3lEiS0ho9DS7hLW7uRpRVd7rZWRl+gBszZ9m8N6P08Fs?=
 =?us-ascii?Q?hF2DWiyOEQKNbvp23v+aG/Wqd2eIaqjGWas223+6KWFerKhnZZps+i0u63Ci?=
 =?us-ascii?Q?jkMnNMFwBofbsJD0GULbnkt+ZSco6gE+H/81OYA4/jPvAgO0u3wDZ/Db6qsc?=
 =?us-ascii?Q?RIwivKnP6ce06Og5E3hFke2Rh2W0itpgYWXughuSoALoGNjJcs5qsvzIFk/W?=
 =?us-ascii?Q?Yjq6KfwFjFXVvynaJomA/ZYLJg8q3qJ3dBj2/HBGBaMlV1FleIl9nQIUiEBf?=
 =?us-ascii?Q?S+eRXuWjH9b99HUJn12/69dBKJCexdZyOtjzlC2+HClIZN4Eddns3LxqmJ8D?=
 =?us-ascii?Q?EZTY2ig5E77/n6nXCU/7qKXw6l1DC+oGI6rYVLTIUKkgk7Y0waJIWof9AwB+?=
 =?us-ascii?Q?SitLMcW76nwMJIugvaJelNFEmMy1EFj1s2YwptJvtiCuDciyCEMa8wicEU0q?=
 =?us-ascii?Q?4NhK3SYW0S4YSAnAJgQ95zNhM3geDoE5HGy9J+HYByjFb3ns1DVWieSPGbBs?=
 =?us-ascii?Q?znXSew76DsGymMHV5m9XMLeNSwvvvKWdgDDKVdEjZAlA1XSqYP1E/Wc+TlWT?=
 =?us-ascii?Q?aLdQ1YRSKbZ3FPdI0NMOvfDnr3EoshoZsQBYeGaB6oor1O2S7RzB9LQW277J?=
 =?us-ascii?Q?XI2XpJqobdTY2jfBUecVyK0uVS2Zh2WTDfT7ms5451vkyPdG+lOmtBTVI+pi?=
 =?us-ascii?Q?SZaKxzsccqHy1wueWVsWuK101Iu8+ncAVhoxegIliyoSU9PCS1AnqcdFGl9A?=
 =?us-ascii?Q?4iZ28PzNC4HRl8nL1iJzZ6WKUlJe1dnvNHhqqW5aBdRSGiG9V02CK9Hnv0J/?=
 =?us-ascii?Q?kuGY1xT5DNz/g8bxeuwA63cnQAZ9Smb5eiUuat+uLUjeVYt/FHq4WQNEUyls?=
 =?us-ascii?Q?LpKsPmQDxfnGxbcAyU1BVqPcjOux+pTjzWS8uxaTznUfh3ppxOvurt2g106d?=
 =?us-ascii?Q?5lL3m/OOEqD5U5sUXemChveS3T8oMwgu2s2an+QKfGCrhhxYRIoLtdoCzCtN?=
 =?us-ascii?Q?xjQJDsTJ/j2z3K8LvsRwLR0TuNWRimJ+sGms5wa01zY3DkuuHcMPxYj5cb6K?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef541a20-f3b8-4ca3-67df-08dbbe5ecfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:04:22.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMcv1NxQbsQWH+oSUp9XmX0kTLrk6ZaExXMgx+2gOHv1sel5moBJmQFqdcmS9/K0s9902Nt4vhvx+0QcoJw9rCQga2cs1GG8hcbQO2gl/UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, September 22, 2023 3:34 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: green.wan@sifive.com; vkoul@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; palmer@dabbelt.com;
> paul.walmsley@sifive.com; conor+dt@kernel.org; palmer@sifive.com;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Nagasuresh Relli=
 -
> I67208 <Nagasuresh.Relli@microchip.com>; Praveen Kumar - I30718
> <Praveen.Kumar@microchip.com>; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>
> Subject: Re: [PATCH v1 3/3] dmaengine: sf-pdma: add mpfs-pdma compatible
> name
>=20
> Hey Shravan,
>=20
> On Fri, Sep 22, 2023 at 03:20:39PM +0530, shravan chippa wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Sifive platform dma does not allow out-of-order transfers,
>=20
> Can you remind me why we determined that this was the case?
> IOW, why could we not enable the out-of-order transfers and get a
> performance benefit for everyone? It's been a year or so (I think) and I =
have
> forgotten.

sf-dma is used for all Sifive RISC-V chipsets, but we will not be able to t=
est on all of them
in the microchip polar-fire FPGA SOC (RISC-V) platform we got good throughp=
ut with out-off-order transfers.
so we thought of having a separate compatible name for sf-dma driver to use=
 out-of-order transfers.=20

Thanks,
Shravan

>=20
> Cheers,
> Conor.
>=20
> > buf out-of-order dma has a significant performance advantage.
> > Add a PolarFire SoC specific compatible and code to support for
> > out-of-order dma transfers
> >
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
> > drivers/dma/sf-pdma/sf-pdma.h |  6 ++++++
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c
> > b/drivers/dma/sf-pdma/sf-pdma.c index c7558c9f9ac3..992a804166d5
> > 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/of.h>
> >  #include <linux/of_dma.h>
> > +#include <linux/of_device.h>
> >  #include <linux/slab.h>
> >
> >  #include "sf-pdma.h"
> > @@ -66,7 +67,7 @@ static struct sf_pdma_desc
> > *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)  static void
> sf_pdma_fill_desc(struct sf_pdma_desc *desc,
> >  			      u64 dst, u64 src, u64 size)
> >  {
> > -	desc->xfer_type =3D PDMA_FULL_SPEED;
> > +	desc->xfer_type =3D  desc->chan->pdma->transfer_type;
> >  	desc->xfer_size =3D size;
> >  	desc->dst_addr =3D dst;
> >  	desc->src_addr =3D src;
> > @@ -520,6 +521,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct
> > of_phandle_args *dma_spec,
> >
> >  static int sf_pdma_probe(struct platform_device *pdev)  {
> > +	const struct sf_pdma_driver_platdata *ddata;
> >  	struct sf_pdma *pdma;
> >  	int ret, n_chans;
> >  	const enum dma_slave_buswidth widths =3D @@ -545,6 +547,14 @@
> static
> > int sf_pdma_probe(struct platform_device *pdev)
> >
> >  	pdma->n_chans =3D n_chans;
> >
> > +	pdma->transfer_type =3D PDMA_FULL_SPEED;
> > +
> > +	ddata  =3D of_device_get_match_data(&pdev->dev);
> > +	if (ddata) {
> > +		if (ddata->quirks & NO_STRICT_ORDERING)
> > +			pdma->transfer_type &=3D ~(NO_STRICT_ORDERING);
> > +	}
> > +
> >  	pdma->membase =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(pdma->membase))
> >  		return PTR_ERR(pdma->membase);
> > @@ -629,11 +639,22 @@ static int sf_pdma_remove(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +static const struct sf_pdma_driver_platdata mpfs_pdma =3D {
> > +	.quirks =3D NO_STRICT_ORDERING,
> > +};
> > +
> >  static const struct of_device_id sf_pdma_dt_ids[] =3D {
> > -	{ .compatible =3D "sifive,fu540-c000-pdma" },
> > -	{ .compatible =3D "sifive,pdma0" },
> > +	{
> > +		.compatible =3D "sifive,fu540-c000-pdma",
> > +	}, {
> > +		.compatible =3D "sifive,pdma0",
> > +	}, {
> > +		.compatible =3D "microchip,mpfs-pdma",
> > +		.data	    =3D &mpfs_pdma,
> > +	},
> >  	{},
> >  };
> > +
> >  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
> >
> >  static struct platform_driver sf_pdma_driver =3D { diff --git
> > a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index
> > 5c398a83b491..3b16db4daa0b 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -49,6 +49,7 @@
> >
> >  /* Transfer Type */
> >  #define PDMA_FULL_SPEED					0xFF000008
> > +#define NO_STRICT_ORDERING				BIT(3)
> >
> >  /* Error Recovery */
> >  #define MAX_RETRY					1
> > @@ -112,8 +113,13 @@ struct sf_pdma {
> >  	struct dma_device       dma_dev;
> >  	void __iomem            *membase;
> >  	void __iomem            *mappedbase;
> > +	u32			transfer_type;
> >  	u32			n_chans;
> >  	struct sf_pdma_chan	chans[];
> >  };
> >
> > +struct sf_pdma_driver_platdata {
> > +	u32 quirks;
> > +};
> > +
> >  #endif /* _SF_PDMA_H */
> > --
> > 2.34.1
> >
