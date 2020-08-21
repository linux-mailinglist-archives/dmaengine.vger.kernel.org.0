Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1024D1BC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHUJwK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Aug 2020 05:52:10 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:56486
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgHUJwH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Aug 2020 05:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB3gFVYqEg4rMs6VvmQ84+2+sb0QDIUAkQflzFT7JDzRGXzC8queVMFXnOxNKlin1nP/mwLrpp8QpswYXbj9cRDMhtsItbq3CYaCf4+9xObeeMhuxSRFWD4OejXBzVi4S7MmUoH+tHcz8YN1Mn1+34EPWD6XgnsbWpEPrSr5FJATwRGHY5poFI8KzuFhoySAv+weuDEjzjUaVA1yTAT0L1bclsxiX+fJhUtaG11l9S4F8zAbgq5aOlpKsZJW1Eh2TodO26jorDm2st/P/OrgVUMKJrMbuBjDtzh7n36LR3hDlTlT8VufWudfyMQk473pUGKm6hVwXIaWkjr7A3khcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y40jIdXqSjeJyX4PsUQ9ODdn5bUlDTpJNYivUJSuXI=;
 b=JVMfsm3SRs/Izqk1gIPS1e4jMzSK1yfNSvrTAZLju6phLsSVwNnrgTxI7S9mS+03yvo119dNOAIgVbzR4jFbjR1S8TRkxkOUjzeUCaii1g7gNoxlOIaeoyGypMCD85H9TyFwFhuSUsVZFUoB8seIn8hU5dCHi/O8buElF5xM2H0rJerTqXYsp//TWOGsV2fXGocSjvNnwgGplllMkCKb6uhfs2cVBn8AVgK558oBs/onLLVCgYdhhyIKo/DJBNNgZoC3/qePH+oq2R6tu/eHR8WnvsXIu6/aadD/B8otehMzE702HqqTRrULkOwHVSE0QgnX5w/FqTKmYzS0hH2J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y40jIdXqSjeJyX4PsUQ9ODdn5bUlDTpJNYivUJSuXI=;
 b=VDT1FBeOURzIfGzWZtYbITCrgRArGgVdFsT8fHc1iyYWLpHv8aq8KD0TlVIJW+eVQSxZFAnaZx8jU+CNQWwi+/0j6nsnKfrZ49zu2t8qdVasmqbVQw1MW7Y82Odp/wAC5VMxraAZkqfPCnNt9LICS/ts+OhraaXm911dAYwMcPc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3711.eurprd04.prod.outlook.com (2603:10a6:803:18::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 21 Aug
 2020 09:52:00 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 09:52:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQbD9eqMlwY2U27XyctTVPmVak3Rd/wgASnXICAA2IfgIABSsWAgAFIBOA=
Date:   Fri, 21 Aug 2020 09:52:00 +0000
Message-ID: <VE1PR04MB66386A43E2BCC5B758D1A71A895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <20200820065221.GF19745@pengutronix.de>
In-Reply-To: <20200820065221.GF19745@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 097eb0c9-f049-4500-28cd-08d845b7d9b6
x-ms-traffictypediagnostic: VI1PR0402MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB371166538E756AEADF38C128895B0@VI1PR0402MB3711.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6hn9tmks7/tkOwxMbBBNzb8gPsV/7Yiqc3nxENZUkmYccM9jnFboAXjspVYH8oKu0gKdlCdq8k5EpRuTr49UAXq1yBsuYXy2WEa4U2g9zBwK+kRtZGUwgD4TmxRNVXIdDf3PPxaDzM7YZOSCcULarC1EXEaBwOcW5g9CzCTapRF2fjAE6/EZuz03TaABzUcXPO3Dy5jVqqZI6xHNt0b3AiRNZqJbrRGf1nGhEQ+FnmE4n0VQnGxFm68yzotyD/uXUskxsIG2gEicfPrZLlHWdELN9YYr3SaMMGRvDBXpLqUHCXCFFKKYHKxvdiMqJ6p2/QVDgS/7riiyleMvOwTkH6TdLPNWtrrxwpdyJfL74BLqELxERTE8i0TN9FEe4wHDvZQDOWZIVJXzsjtQJijtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(9686003)(71200400001)(966005)(8676002)(8936002)(86362001)(478600001)(54906003)(66946007)(4326008)(110136005)(7696005)(5660300002)(316002)(66556008)(66476007)(7416002)(66446008)(64756008)(83380400001)(2906002)(55016002)(186003)(52536014)(76116006)(33656002)(26005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9m9kvxJP/MKG3SqF7SYW/hf1CHuUtprmGV+IfeJATDqWwSX3PlyUBvn8WOqYTxUUhdEIXl0Dciyp9dd5sdlz7v384QZwrmofA2Z3Pzassy1o23E3PHS4FdP2fcI4mPSpfaIzGZOYMNkLFxswouqPOyP3z0KmFTQfJzgATcBfWKlv4MUfCrOhLNUEmR5T5IO74elDmLzMmqrlcI9pgCqwNYBzNEjnE4nX2dfng4n1HHT05miEoNPZQbS06z0AJxllDl2n/5+hlFQUjLPVq6U/IBLvcJRxtrTKZ2dTf4U66HgVfyF7H85jRSjFlI22tdk5VCLH7jMizQ7di7QtdusJbmjKCTetKi1RRR7xXq3Mcy4Qx3YSGgd0FmdpmChD3WxdU/baVpC255O6iuBFxFAN8NegOJ7tis12NmhPTsC/Z1AdjE2ouyCkSCi02Hvn4te7YdLHMm8k6U926K6RmXI5OauJXvybKPRpeIGJvpl1Sdb1W4KeQaKZZRsXma13uMh/vze/lgw2nwg0IjkcTrvdtRpICLkc1UaXszsNp8JwzoODIKpluS39aSLwTfB1JGuzOggUkjZZBWFecaZkZ8I162p8pJSVE5IWM96WMFgot7BbHWgitcfG1OtnJwK+vJfEQQVhH6FpQfWkQvdBHrwWGQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097eb0c9-f049-4500-28cd-08d845b7d9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 09:52:00.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZU/iO6CvjQ+2nP/PrMxq5fVccSiMqsbS1EVsTGlrpkFfZYbVyl6VHikPNqZNwAy40K1Xpus8X0HphcsnZozew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3711
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/08/20 14:52 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Aug 19, 2020 at 01:08:29PM +0200, Lars-Peter Clausen wrote:
> > > For the first option, which is potentially more performant, we have
> > > to leave the atomic PCM context and we are not sure if we are allowed=
 to.
> > > For the second option, we would have to divide the dma_device
> > > terminate_all into an atomic sync and an async one, which would
> > > align with the dmaengine API, giving it the option to ensure terminat=
ion in
> an atomic context.
> > > Based on my understanding, most of them are synchronous anyways, for
> > > the currently async ones we would have to implement busy waits.
> > > However, with this approach, we reach the WARN_ON [6] inside of an
> > > atomic context, indicating we might not do the right thing.
> >
> > I don't know how feasible this is to implement in the SDMA dmaengine
> driver.
> > But I think what is should do is to have some flag to indicate if a
> > terminate is in progress. If a new transfer is issued while terminate
> > is in progress the transfer should go on a list. Once terminate
> > finishes it should check the list and start the transfer if there are a=
ny on the
> list.
>=20
> The list is already there in form of the vchan helpers the driver uses.
Seems Lars major concern is on the race condition between next descriptor
and sdma_channel_terminate_work which free the last terminated descriptor,
not the ability of vchan to support multi descriptors. But anyway, I think =
we
should take care vchan_get_all_descriptors to free descriptors during termi=
nate
phase in case it's done in worker like sdma_channel_terminate_work, since t=
hat
may free the next descriptor wrongly. That's what my patch attached in
0001-dmaengine-imx-sdma-add-terminated-list-for-freed-des.patch
https://www.spinics.net/lists/arm-kernel/msg829972.html

>=20
> I think the big mistake the driver makes is to configure fields in struct
> sdma_channel and also the hardware directly in sdma_prep_memcpy(),
> sdma_prep_slave_sg() and sdma_prep_dma_cyclic(). All information should b=
e
> stored in the struct sdma_desc allocated in the prep functions and only b=
e used
> when it's time to fire that specific descriptor.
Sorry Sascha, seems that's another topic and your intention is to make sure=
 only
software involved in sdma_prep_* and all HW moved into one function inside
sdma_start_desc. I agree that will make code more clean but my concern is=20
sdma_start_desc is protect by spin_lock which should be short as possible w=
hile
some HW touch as context_load may cost some time. Anyway, that's another to=
pic,
maybe we can refine it in the future.

>=20
> More specifically sdma_config_write() may not be called from
> sdma_prep_slave_sg() or sdma_prep_dma_cyclic(), but instead must be calle=
d
> from sdma_start_desc().  sdma_config_ownership() also must be called late=
r
> in sdma_start_desc(). 'direction' must be a member of struct sdma_desc, n=
ot of
> struct sdma_channel.
>=20
> Overall this sounds like a fair amount of work to do, but should be feasi=
ble and
> IMO is a step in the right direction.
>=20
> Sascha
>=20
> --

