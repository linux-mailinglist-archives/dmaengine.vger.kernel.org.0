Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231F93A97F7
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhFPKqW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:46:22 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:44964
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232223AbhFPKqV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+cedB23zm6h+Mut+dWY77MkX4IwFzjh4fwbCO9G/Ms2StZdkfDnKcF2ixFhgAy0hW5FXKDSbUnKvQmUso6ncQ05UqJzDKErA6Dv0heh/lyZEjtayQJerRw3oRkceUArXcGiwVMsfBLXQUTvOlhJYYRUom0ygTxt3um1wOrcaXsmOuTNOtBdqQvLLfs/zlei0sPInjFkM24CNrfAshwHBNIC1up8rsO18qvVkC/fgGJWZNhLCxuZeF9J0wo1CmJRwMhYkwLFixvfkNcWJyVIGZCpRQ+GwDSmJGsg5WepXil9Msr0LXHYh1NBFUTFbM+IWE+gzi9T+tsVae+kGJYf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4I0sbedGUx5lPMPCA2V+ocyjB2yKSXhOyRVZrmyCFY=;
 b=jRJoVQrUCVL81G6B8QQXD9OMIn/0mbFl21W2MdjJmkF2heuwBC2otWn/x+EumcwUSDXcl7mkHzHK0a9pMpHUqpSpWmk7muKk8WtaZ36/2HPBoYLfmHcNzbOqDPnulQXHV0tCmOc46gnsdWlqq64B93PiXwuPeJLHqHqZJ8RWW3ob2TH8rC3cIzZJ1LggppGq+NDiT63y+agJCskln7FbJUEUIZGUcSJ7+3yHV70gjyvAHSmg97oUwWeZ1+GBkAD1p/4WYnbmVQj7cOIQO7Pd+TpuKxUwCKqzjxW9BYpiwOYOL9xsfI1Y59/+616hF2AIcJ+8t+2SdORxjP1uCTTCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4I0sbedGUx5lPMPCA2V+ocyjB2yKSXhOyRVZrmyCFY=;
 b=czyooZxk6qJDmPA+FB2uOnN6s8ukDTw0pAGn7++12G0AtNr95lSXU2J/YAoDbX2wYTvj07YTAGbnsl8yYC4qwwn8Aw0gbrP0BzFP1n+6Yt4xe+Fe564mWsA3HMcD+pQxBZtWEljFMl9x54LoOmPLAiHJnx008dTNI06BCBrL9JI=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4734.eurprd04.prod.outlook.com (2603:10a6:803:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 10:44:10 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 10:44:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHXK33LUkqD6t3KUUabL8+87acFPqsPOqgAgAV+imCAAElmAIAABENQgABgQoCAAB74UIABVEEAgAAFvTA=
Date:   Wed, 16 Jun 2021 10:44:09 +0000
Message-ID: <VE1PR04MB6688372FF6AF5607B7F80FF9890F9@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMhDvlPrFvSZP//I@vkoul-mobl>
 <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMiYEZDgutW+KRsO@vkoul-mobl>
 <VE1PR04MB6688F98FE0B76AF20392DD6E89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMnPeLHM8SXTEVQP@vkoul-mobl>
In-Reply-To: <YMnPeLHM8SXTEVQP@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [101.224.54.105]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe671ed-4d3f-49ca-6f58-08d930b3ac82
x-ms-traffictypediagnostic: VI1PR04MB4734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4734FEFD2C31769C474104B9890F9@VI1PR04MB4734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LwtaBpJsHjRaQb3uoHa5cefWkEp5yEjycjD4XjjS2QsDcU8wbL6et628o+0NQu9M1qE84iuhzaTJoFqaR89yk3QhnJgvMFHj1BNzy3dRgLNys0pxfobniObepN1iLQYXV/INyttANSFjrS2BJmGne8jx5Hy4K0SDbwwqwsjf/Xs3RQnFklNPuz14/xGJ3KWF2MxkXwxu/22C8Z3gYOQWiX2KFxunfDBKymTNr0NFvuf2zrpbmoq222swDNgNUG6wlEQUYXConwmK9FM/PMuV6+9XXV2bQFq21Vvzz7KwAS75CnoPoa1AG5LVX52rGxQgK7iQsrtLxKvWDadPFF4cMFfloYdc/VOkoxoEj4LdU2vhBjzUifmR0Tk32r+ExOgOUjaxnPy/RBqkbZpziBzI7c7dLfqamfxPoNs/J9lD0o1CsDd4ey/Rey4e5O0pX3lwUrc992c4GTXBhFVsHEHfwqAtM85/9JPzKsJIPZ3JSM4345R08nXq/0S7gaaUFv2hkBg2hiMZeK8lq0Lu8QE0pW9vFAtbdTlVxUekNdGQaVFbvvPG7y74HbqBvzpUMJJjyNuepi8WWg0K87UKwA0DqmD3FxI/8WmMDKw7ReuQ30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(66946007)(54906003)(38100700002)(66556008)(66446008)(122000001)(64756008)(9686003)(83380400001)(55016002)(76116006)(33656002)(110136005)(8936002)(4744005)(4326008)(66476007)(7416002)(478600001)(316002)(2906002)(26005)(7696005)(8676002)(6506007)(5660300002)(71200400001)(86362001)(52536014)(186003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZUqBpPEZK+cM95SvsSCTU6Zso7Zu4DCHj77HzOvYceuQVYEbzChR8fMdb7?=
 =?iso-8859-1?Q?jBKzRbqVKwvigWtb3Pv7zvEXQbKlkyVV23/c9k3GjViaYyTfaz6zsQEO94?=
 =?iso-8859-1?Q?xZb7yzGwCd6a3X0BbWN4TD5hYQUp35Rqa+FUr0SREzF/w0awKALtJEv1Wr?=
 =?iso-8859-1?Q?fXqfTjYv5IJQN7sI+zWcjA7CLw5G3eUwlHoO3Qsen3HWh0tBmk60R3NvL9?=
 =?iso-8859-1?Q?iKxirIpAQ3yntZrKiqc8R9rmzx9nfGolPjSsqsCYNIKcGHK/uhXhgpNP6W?=
 =?iso-8859-1?Q?7qEhDMHEAMsmmheMHH8XhaFBNPaBJfb+vjmdWt5i/Q8ZTAROMxuuaMt27e?=
 =?iso-8859-1?Q?U1l48Byt1t4uSnVBmS5dB8N1TrDd27ArHeg/Fe6tAIXXfITc6cDDf1bpmD?=
 =?iso-8859-1?Q?ys/bCAuiNq9Ge/JgXFtvZgTkrPSXzKxmo9ewv+IYj5e4Ozo+cvjb6zTiVC?=
 =?iso-8859-1?Q?JRcyJ+9Cv8H7kg1EaXGfK3m/vs6r/t7DQmvajyjmHwl8dcuVjVj3miVuXs?=
 =?iso-8859-1?Q?Nj7NHuk5ZHb8UFTi3ul2yoIJwOVOK2uMu7Zrnie8ycldg0X7GWe9N8qsUD?=
 =?iso-8859-1?Q?w90/sY63smWwtmL3nNtfaDxIqxSgKLIFsU7WeoWE+T/RyMSLiDtZqcx5gd?=
 =?iso-8859-1?Q?WFyqH6y+ME52OVGwKOVkVp8w7QvYCDKhmNeR0Fi+hZG2k/cSNhRlUPFNcI?=
 =?iso-8859-1?Q?pbhV8yZXzzbc2xNT2vq7dLE2/W2h6duuCFLcXKIj9EPSEIG7OirlT12/gJ?=
 =?iso-8859-1?Q?UqD327wd7GTXYDOinKmzbaE4cdHK3GJtkflAq5kC3N+SKoOC3Jf6eSo+bX?=
 =?iso-8859-1?Q?0VtEywBmA8cI2/q3Cza+Mdw1TsKepY9fXknKrbdbhGfZX8BCmMrOi/TkXP?=
 =?iso-8859-1?Q?jfPqZBW6pXw2nm8QMiQMrejf+NwJ96bdUB2w++sdBFw1lIuI4/XAeMjMOa?=
 =?iso-8859-1?Q?n5ISm/hJQNsxLDQnb6N93dwrdkvBQXzggNshNo/lzus8vhgkl6X2aS/Kqi?=
 =?iso-8859-1?Q?JLbm5znbZvexSBUTLQ3YXuFCLunavdk32RaPwQx0CPWL2d3N1vIcM0nYv8?=
 =?iso-8859-1?Q?G6yyA26IXbSNXtvVG8ciw3SjOQnW1eklejDCd/B7r3ewgWTOA61D1qYEHT?=
 =?iso-8859-1?Q?k6xh3Gpf5awl9wvZWsn+1ttyTpBsmG/w8rHOn1cbm6nimLJ1wbhLEhqn0l?=
 =?iso-8859-1?Q?nsLMyzYxqAzYErzUvjFHl6zbQy8G2/wXv63BjY/vwmyr7zCKerDjqXy/wL?=
 =?iso-8859-1?Q?+TARjGCr1VqT7Kexak1WidletB1bi8wc94xVr46AekISoVnxRPfl7b0BLI?=
 =?iso-8859-1?Q?kq4zxe3NVxptlsLKi2T2ig+FfOVUFdtrtqRkHxqo9mIf8wgRGM0O2JFbvW?=
 =?iso-8859-1?Q?yTJLMBBYgz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe671ed-4d3f-49ca-6f58-08d930b3ac82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 10:44:10.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+0o6el0tpMiJNHKE+Zulz1TDOWjtbNm9VlI3RUObh60nn+gU8PP+KlFY5M/h5fGDz+wuDCOL1LvL6HRu/plrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4734
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16/06/21 18:16 Vinod Koul <vkoul@kernel.org> wrote:
> On 15-06-21, 14:10, Robin Gong wrote:
> > On 15/06/21 20:08 Vinod Koul <vkoul@kernel.org> wrote:
> > I thought the patches with 'spi' tag could be merged into spi tree
> > while 'dmaengine' merged into dmaengine tree, the rest of dts patch
> > merged into i.mx branch. But from HW errata view, maybe merging all
> > into i.mx branch is a better way?
>=20
> Are there any dependecies between patches? If not all can merge thru
> respective subsystem. You already have the ack, so I dont mind if you pic=
k thru
> imx tree
Yes, this errata need both spi/dma work together, thanks Vinod.

Hi Shawn,=20
Do you have any comment for v14? If not, could it be
merged into imx tree including spi/dmaengine?

