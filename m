Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC521D0A70
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 10:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgEMIEg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 04:04:36 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:37389
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgEMIEf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 04:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl8vCc8EqPRkfmL1A3oGB1AgErlcmDON2O7kdXFs8crOy+n8xX32pHPtGhWCVC0RS86ikTcLtgg/2Kyrv7HobOukwymjScSO46vh1U75vfGjE1dzddB+2kjOe2Vh0EI1OAJO698ed+gtyki/H/7hN7vOUm02zm2So2WnkQzS7oFYrby9GdaWkPJyZ2dVJOYJASk1vtoLxp9NTJW3xH1+z9xEfbBqWiiBQ95HxUER4Ls8IiFjRHQASTt0zipVl90or9FxL5rnWgbkLOfNoN93PATAbCHf+ZaWaljfp0i32yBXTT22rNvh4CNDStAffr/lcK1HuMTAvs0S2M693SYmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5P6k7UrOODGPA4uK6HpwyBYw0prUzYggxz8vKDfOZc=;
 b=UaVcqQgt+nNh1ZTt+VD5nubKSDcQWTd8DV6EmZ4NxnxeU8ZQq1kaihr9QApyPwyqCHXBL6AW+eTb80bgp7ewJHrh5LVClkykR8T64KbuUvs2Tergc33UKioLHGXuoYR5MeEY020eqOb1byad7KvZQs0KYsUEdufm5HiXQckjPO80s94nsYnl4UrZjhcsFjwy9bF3+oRLPXG2Jv4LPbcLOemN5qrhrxdfv3S7qilKYHHrAPafswFpl1RgjcbJWBRETu7bpXRZkD5UGBGpFpyVgJuWBaFyi1h+oG7Zwp96URD8gqfg4k/og0cqGyvCuoVZa/9FN3e1po+u2zUNYbaL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5P6k7UrOODGPA4uK6HpwyBYw0prUzYggxz8vKDfOZc=;
 b=OWWcTn8bkWypUMRcGvuJ96f2a6xuuNTR6yi5cyJFMrFM21Fe4L82CPBK27BAYYnETp+dYBnsrcaHC6gfL2Hm+TEIIT7Mu+VsMEYekeaT8udR2os4TIFD5P5pWh+o4xGRFT3JLQeXOYfmxaAi3b+Fw+r/Fp97fEUU/Hr/jVqllSc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6672.eurprd04.prod.outlook.com (2603:10a6:803:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 08:04:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 08:04:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 RESEND 05/13] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Topic: [PATCH v7 RESEND 05/13] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Index: AQHWJ3cg+wHd5ZE+ekmEy8iGd1YNmqilii+AgAAgo7A=
Date:   Wed, 13 May 2020 08:04:30 +0000
Message-ID: <VE1PR04MB66381A28CA5C64A0149DB2D089BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-6-git-send-email-yibin.gong@nxp.com>
 <20200513060553.GK5877@pengutronix.de>
In-Reply-To: <20200513060553.GK5877@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d8a7b3a-20f3-472a-b13f-08d7f71443b3
x-ms-traffictypediagnostic: VE1PR04MB6672:|VE1PR04MB6672:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB667233AAF5ED7C2F4AA04D4A89BF0@VE1PR04MB6672.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrqY6h8vymMm/oibjoDA4j60CvoOUZy1s8oiUlJCMoT7G4byX99AzSN4zhUTKiuMFt/m0lC7lUxSEuEmw0nZ/h4vSiz0M1wEttYHJvsq7Y7wRc78o+Psfgra3tm2ETToickW12wXdBeKCtHB0Hs8i4BHt/9RyZQ4sbwUZkqqidduajrqapHntqQIWBw8rUOi4eZN0Vrn2p3yh1fZ0QCgLrlU+kySumvNQ58fIf2nbNv27CE0l1zhvZTwIRfSamaH3vYfDw6r0QsujKEXSnvKpBtkHXJsMsTFDjOy/WEfpD+5ueJ5adJF7TCVh6MKfgQJhPAHxAAQSCFXvjp/jn3ScmNohqKHoNkFY1Yq+kLAyL5QHgf9eH5UTGihdtfapQlEP4G30Mkvqq7bdWA4eKhW+XwN9o0iVbDPpFfGavLqdDklDfWdvF4ZiOjCAgxJKpSQTDCgSxswEexvkcw2kW0UbZLWxjeEArjkSJ8BkktXkD2doFcbPJwld/WwhtAmAY6YnLOB6n6VKUQoYmE2Y4J/lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(33430700001)(66446008)(8936002)(9686003)(66556008)(66946007)(5660300002)(7416002)(52536014)(66476007)(7696005)(86362001)(2906002)(558084003)(55016002)(8676002)(186003)(33440700001)(76116006)(53546011)(6506007)(71200400001)(64756008)(33656002)(316002)(54906003)(6916009)(26005)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NCE3H2Kmv7OiN8INKzVCSmAZeAXkO1Le883HCd2T+bgLp0tSmawxECseT9OX6fAianq6CO7uxCXYgLljW0kBa5mhOzI5xfDATRak321Gi4dpvnRIIhbutDuWxbE/FmvrSLuyy7OFr3iDn7C5mKHVjT9+4SOQbuwrukKAujz0RW6Yk6ljTajF4QBio4zbL6ol5DB83rxoTU9WkLwlONE5yeZxv0OObHuFlZncx4sQpARYhvR7KJVVHtBBn381NHk3U369Xc4SbEdtzv1XoaVydBwnBzNmnCZJB5BsKUiBKC0OkOM020YORe9v5igxHpeeNkIo5v4ZFzZzspR2Q5nYQZzkfss5G5fJ/0rEDbmM6+zBpRETIlG89xxEXGjoie5qz4QU5bVhQLQW0MPUX/785NExG43ZZf/uD1MBx+mGqpca+N+77OOeBv3G32uhwNxODgkpgdYuiB5SVutsGw3Vn+HnDeHq1p7ZROWvfTHNh1w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8a7b3a-20f3-472a-b13f-08d7f71443b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:04:30.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AckU7Rv7YFuPhV8hebWwS+FDpT97nlIrfMQOLLmHR++s1rFCGyigNllvqN1hLIYUmlupMld4BILefSdDT6WdZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6672
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/05/13 14:06 Sascha Hauer <s.hauer@pengutronix.de> wrote:=20
> Subject: Re: [PATCH v7 RESEND 05/13] dmaengine: imx-sdma: remove
> dupilicated sdma_load_context
>=20
> In the subject: s/dupilicated/duplicated/
Will fix typo in v8.
