Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB524D157
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHUJVn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Aug 2020 05:21:43 -0400
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:40542
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbgHUJVl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Aug 2020 05:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPn9tyRhmJtxmnCkmqlZCp6E5QGHNrUN45PRs2jD+vjhmdigGaUDMvcEBZq5DmsuXDfZ88hXzXQegLLgrECphnO5AwErE7/St8EVwWzDMe5DNnvwYGYKZbO8IijDsw/1sP/8fVJ83lbakVUEhZN4rC4C0/LSCa9mNSM4NfkscsBn38yNAONP1TpohbDVs+tXkF09A52kYZWOfDEqf8TR/IseWR/x7rwnVIXw7Zofrfpxb9kfA3ODK7ea3e5ojdonf7wjFcp68mQ1jMkxHATNo1uy2vVdofILAXJ0nzQvd9j8eTIoingTsGOkknkVSsANSrA2l1BOfO5TZzUlOuD84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnwjXpnGN6Gn0m2rSOMDdAe9yhT6nhfknyihg4yeoUQ=;
 b=aQd9TfY2LTUBBYe3W2vGEXetnZAjfYYAV3uJTseRNcuAFx+fnKGFHMwNBu29j9xQ/0b6w5cEgGjsdRsCUK5enwP/fZsAXBRADULK7ptN9aXVyN63neJi0teqq/jeOxSNc6XM6tbIqxrFmYCvuE5uDLcxggvaN/uQDOFKDs9TgRnnPRCyvz/da/juqLvwTS+xGUwC6TBJ6Rq4yMyEUPFpg7TgXGEt6LdxVLMg8fxj0yM82+XbBkZO3rmhrP7+a734yXDF5T49jyNcXah3vcvUUHQMbVA/5NLhEz9atKx2HdwtGWyI4tZuum0xzNadll/x11ZirpA53NBG64JMOFXK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnwjXpnGN6Gn0m2rSOMDdAe9yhT6nhfknyihg4yeoUQ=;
 b=DGt0uP7VEcmnWLZTbqSOfcj95SfdqS3IMhKsc5sEbYTMAg2nUL0qtUdxVRM2D2KU8bP9SkZ0JEXRYzUfWVvAYirFz2Bf67OJtbOGXLHOgwB/B3cPQD7kq7v29Kd0ydh7uc3lIVGFtOCHi8m+f6B7hK14pXZCRHgXWMRnvcEsQEE=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 09:21:37 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 09:21:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Richard Leitner <richard.leitner@skidata.com>
CC:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQbD9eqMlwY2U27XyctTVPmVak3Rd/wgASnXICAA2IfgIAANxuAgAFCSvCAAT0iAIAATlSQ
Date:   Fri, 21 Aug 2020 09:21:37 +0000
Message-ID: <VE1PR04MB6638271FA459E4068391ABF8895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
 <VE1PR04MB6638A7AC625B6771F9A69F0D895A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200821043418.GA65616@pcleri>
In-Reply-To: <20200821043418.GA65616@pcleri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: skidata.com; dkim=none (message not signed)
 header.d=none;skidata.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4219dbeb-ce1d-4a89-be7b-08d845b39b41
x-ms-traffictypediagnostic: VE1PR04MB7470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB74701A8B9321A2BBF02068D5895B0@VE1PR04MB7470.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pmPoeIX1mNRkPxCBaeSUA4FblZH+F8hvduwamiH0Hh7U3x/jf4J2hHwc3ezBPFvYhwWv39IMrNlRP2nCdzAoNSgzvgGgsI4yjzYrw/3JAYRPBk5vPhnKpH49JyAkMPr/BOp88fwcJ/8xRngRvAjzYnKHaCgfPgFvPD1yxXTSo0mQFhoOnJOi5N2ibiKSI9DTRgyexc/E0Rf4hlHZkgq9SSUZ/B8Rij4l2h22zDuaoDFcvf/Y8+fAM7Zio/JLwCOp6vq7bCTmcQ/bB+BPVSolLjkW4plmTKyEjzHDAKc5TeSLNhWXwRDRG9DdFXIgfHEGpqx2CDFNkarWsgOiprkE4H+kMgg7zDnYzBZS7rhg26dWd4cTwlBtF+HGLWFDqD9WKrBOssmPDsNViyYO5/v3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(2906002)(66476007)(64756008)(66446008)(66556008)(66946007)(7416002)(71200400001)(76116006)(6506007)(53546011)(86362001)(4326008)(6916009)(478600001)(52536014)(5660300002)(186003)(966005)(8936002)(4744005)(316002)(55016002)(9686003)(7696005)(54906003)(26005)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uyfZic1K9d9MbY9sr56IUf9KjAIxmvY2Vq7OPzhKnV25ZOef2UlDp2auz0JFuS/Ogyx4WpQqW04NVscOqaVGKx6CIMt8FGLU7d0PtWPK8CJCUuvAr+zFCR/WTQg7Z8bYzn5dVbKeOs68/+DSt/i0vpUl5mtp/ULIzLZ0Iwv4KigvCT2pqF/oUr2+ENn1ASfbSwNWhizq5zhPXLHXRb+cnHhYvghbeF5uoRFw/ZP8eJBQxirXMlyN1J1h+WnM7QZeiwpSe7+UKa/1q4iSdRJGxz+pUmn+3YSP0vE4MlNV+U5AaCvYg/LzV30cjtwPNkEVoF7zW5BMBBCDqIZgn7GKvqQ9aNpEhBLQHe2WPDkuiPst9OG6qEN5aOEJS+ELd54cgJyOdhu8g98JcYIZ2PSejToQrmk+4YneUC7y8nLAbzn8HaY3L/ZXaIQXnVO5BEMhddFalvAi+XLVSPAGJ9yz+c7NBgUulRH7TxPKvn8FZl6OVVh/Bvcvx8tnw++RO1wsz8VGJqRk0JPNCdOtFKsFnPXfJMwMsj6slzjHAbtP6hkj+BpxtekzXIiufHqRcwwttjujfzcAxBFTHPimlcJ2Y3Cfg9priQLRAgLpoHT9UKFvtC93qEuN4uOG720Ttd/LMdjmFCprqec5McmuMCFD4Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4219dbeb-ce1d-4a89-be7b-08d845b39b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 09:21:37.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2mfbT0XvsRY/38sXwpz2SsysXND0GzAslOkOWp6/HX4ULLwRn2TX3zHIzkDR+Pto3/42GIzP4SkFJ2YI1Q5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/08/21 12:34 Richard Leitner <richard.leitner@skidata.com> wrote:=20
> On Thu, Aug 20, 2020 at 03:01:44PM +0000, Robin Gong wrote:
> > On 2020/08/19 22:26 Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
> wrote:
> > >
> > > @Robin:
> > > Is it possible to tag the commits for the stable-tree
> > > Cc: stable@vger.kernel.org?
> > Could my patch work in your side? If yes, I will add
> > Cc: stable@vger.kernel.org
>=20
> I've tested the patches 3 & 4 (removing sdmac->context_loaded) of the ser=
ies
> you mentioned and sent Tested-by tags for them [1,2], as they fix the EIO
> problems for our use case.
>=20
> So from our side they are fine for stable.
>=20
Okay, I thought that's just decrease the issue in your side not totally fix=
, and the patch
I post in https://www.spinics.net/lists/arm-kernel/msg829972.html
could resolve the potential next descriptor wrongly freed by vchan_get_all_=
descriptors
in sdma_channel_terminate_work. Anyway, I'll add ' Cc: stable@vger.kernel.o=
rg' and
your Tested-by tags in 3&4, then resend it again, thanks.
