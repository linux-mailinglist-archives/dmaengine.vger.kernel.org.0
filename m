Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D64C0D84
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 08:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiBWHpo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 02:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiBWHpn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 02:45:43 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F43EA87;
        Tue, 22 Feb 2022 23:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUag4PQun46npxSjuJGj61vk0WNUjfsFZSKL7XXfySb28AcbVivyVwIKXhMr1gECfAaaGh6GltsN6b4hs2Uuh9Q412YJk3H+HUTZHqpFXQaFec2mirkQ5ZLEwiknM/wpCxrojJTBdebLdYLlF+gCuqv+0btEMHInuGAacEEC0OzHd9hSeBsqZQ2XKHzwEMebS7u4Zm2lGwcnVZjUAtwbtrH8hm0FBvYaLPTj+2kRdM/V8KiI7KNAUcZow04Bbw8J0WQ8Qqu9jYpoXlYa+aKlvsiI3AyLK0xBQVDqS/ONHMD3XgRZZQX8ZG47W03nlbzDFfU3NoJsoV41Yhb+Vx3+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmwAkEoXFKxqhrgw3f0a+Gf7yNJ5ELtU4Kwmhtd737w=;
 b=aVmtpoEMczYFvnq7KPy8JHyYd9FUtjEbJVoBJWdHS34coRl3RHuzHOZ0E7Wton/lqTh/scTSjQXRQy5GrBf7g80mC2BKFpy0qUv8Fyuk+yOeh20vpqckMq8zr+1mBG0/PuDLmZPPTV1ruZBSYad1iEQXuKYx0O1RaqrJCiIOWj/ilMVv29vhLvceE0Q3lPBzuVp4jFmnX102nku6gKHH3LZt7DwD4hmGmIA75uPyDanHk8k8FY3ko2lJpCJJbUMvKG2lDspUIIFWrIVclcFdwqN/d8iHvRju8BAdGOw03IXhnErZlEL+F6jPJmnPsvu+kGQES+2nbNrk65dyRRO4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmwAkEoXFKxqhrgw3f0a+Gf7yNJ5ELtU4Kwmhtd737w=;
 b=B0VMidRBJ7Komimip0vWcCgOxQwphXwf7ZMFDbeBsxrr0jDjrRKiv2wxjd0OgYv9TmIxgvKtS2TK834s1tx14Lz7FQU+m1GYG3ownRLurU4WrDeRPZTnZ2vYFJTTkRbMwQayavldgS/wbtNQr9jCe7kkK64ZYgp3Q1OxilMB4QQ=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OS3PR01MB6610.jpnprd01.prod.outlook.com (2603:1096:604:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:45:14 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:45:13 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: RE: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Topic: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Index: AQHYJPMfNzaMXGg9ukOz8Sma94IPu6ycRUGAgAFkUmCAAJN4gIACiUJg
Date:   Wed, 23 Feb 2022 07:45:13 +0000
Message-ID: <TYYPR01MB7086183461B9343A2301B4E1F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-6-miquel.raynal@bootlin.com>
 <YhIcyyBp53LnMbjU@smile.fi.intel.com>
 <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <YhPDZ4yb50sMdVgV@smile.fi.intel.com>
In-Reply-To: <YhPDZ4yb50sMdVgV@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7afc443b-072f-45dc-c655-08d9f6a06d5c
x-ms-traffictypediagnostic: OS3PR01MB6610:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6610FE049100971C63258D24F53C9@OS3PR01MB6610.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqVbFSA5rzDhMJy7JvtOqjB1zYSPGigm4mANU1Tb953znYOcnyRDppbs5wECltwX8trKepOJBYeUVxIm63Ph78Zx2fUuXc5gsCFJa+Zspq/4QFqaJUBhsTprTCtZZuRAmptCV5msiwLTVlyIO/mAFcINks2bkWqNy/vY7yOcxm/kUIbu+FZGfyEqBAq7Z68H1M8S22DG4Kdq2nlW3uZeJPSB+3wxNKbIWAsBxNAuoFQ8IbV6RUdrizgBq5hgug2FeDNZmtYdMyewUXkYgDRXI4GJYMQz0g1b8fB9X3iG07QczGA+tZOkoTU537gFrTNLxFBjca5GBfFzyJIzq0Sf0YaVTgKiNjC6MP7v07e734UQXHrLKCKqA7cRuMRbDZn2hRgQj9DUgl9JhnGFt56+Fe/yefHWZ/M0PzeXwkswCVBOogHBno0/WGbtN/b16JJEDVQdCwecUy/ZbaHKgClJ82mIntooclzqDb7bD4V6nE/i1DSofnivFDFlL6QltH/BU+4ssCqVcrtHMypuJLuXL5ujCoZh1EUNr+stI9M9jXE1dxsbXJkKwpG8+KCUadmfUKkuq8tEUnaYQdzEpAy7Cl8a+UnB1St2DTHdJcCEjp8TOkoC504617FJDbKL/L9qWlveN1NESlKtv5EVez9QCMbJ0LZd/+7mu+VJlkC5Q20pCBQzxO0vLYhwApnz9rw8MI00KWJzmUP8wLWL/i+amw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(5660300002)(64756008)(52536014)(44832011)(66446008)(66476007)(66556008)(26005)(33656002)(186003)(66946007)(76116006)(122000001)(508600001)(2906002)(8936002)(86362001)(55016003)(4744005)(7416002)(8676002)(4326008)(6916009)(316002)(54906003)(38070700005)(38100700002)(6506007)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jp5m4wMAqQducI7T4xgGOGJ5rxdOPqqFSqcQEKZPtpffYoDoLw8bSYksFu5N?=
 =?us-ascii?Q?iwvZ6qgrZKbMkgbNMJHsrgWbLWHwkHFUgUxWGtAm6OXEHgLrrjvVLyBYdn3c?=
 =?us-ascii?Q?fSsYU51giL97pS/fslCMTt3yFdPpJK4/gzEqdEzeFneq7e2wDoFAYrcSYFSL?=
 =?us-ascii?Q?EjajPlBZqLj2zj5PM1jEy9HRV3VNOG3C+tY9YhrS/RmZ2mPI3N9VD/YVuS57?=
 =?us-ascii?Q?qTRsiCqCOqp8zkA+v+T8o/TNZETWXMDyPnFncWu6Nvvx/qaiWNaVm65hzbTW?=
 =?us-ascii?Q?eX0XBvBrFlegXEKJ12Bw/+Q0rarOuMBeEZIHJ4i6ahU2F/tHoWeCd4FGiaav?=
 =?us-ascii?Q?7gw1Drks9pIV0luiTPCErd9g9PwT40x8ehRoccFmPOTx5CpaUcf3ny9dcftn?=
 =?us-ascii?Q?o4jncwtVONioA9CDq9pC+yVlnUCcM/CK5+TWibv+k/bwQG/GTPNMQD1kMJBG?=
 =?us-ascii?Q?LHQlGAMYhBtJKLWDP+FFlf2A5cDzNQLZ1cx0gS8qHS9uybHXan25UcKjdGMW?=
 =?us-ascii?Q?Vh42REAdTSB5cP7xK/P57dgNcBnIQOR3DQtQCaOPIlEUoMi0vVV6DCLCtglT?=
 =?us-ascii?Q?fIbsDghRfcK8SX7+td0f+oP96T2LYbj9CEqQUw05dmNJccN6/DQGT/EsLkeL?=
 =?us-ascii?Q?ToFyrtUNm+VWsRkk0aFEbFVJLsnsNe7Nb9HeieJC57Pyvy6lyIegMLonrrMw?=
 =?us-ascii?Q?J2C7BxurTTj7O3ekmMzwbtmm/mszgG8Wrmd5xkcRLmhegQct8hFsR+k+mISS?=
 =?us-ascii?Q?7EYDNDtD9cetn9zvZa8cXCUYeMSPIBNpphpf2jUkwLHwijr9SuYeL/iRd2lH?=
 =?us-ascii?Q?baFwICdjBbn9bZVDxNk2SnbpCzfcK6zGlcNzdo/lKqj4Yu6GFslve0th+54C?=
 =?us-ascii?Q?lCKFJ0VTrjZ2+w28/IXD/e0UsivZOIMwS3Uc2MFNzMnIscS/PlIPc/b5hTNE?=
 =?us-ascii?Q?pN1Oya+/xqK9yW+v7/tsLa5aJtvkncU0OIFwljMKVtnR2UE+aUdxI5yl/+JQ?=
 =?us-ascii?Q?q4KWFKoBhEixJEmrZQRaKn8FqM8jtuIQ66rgPW+PKwoBXBcVxugf3HYsdpsi?=
 =?us-ascii?Q?JBftAlnNdaTs8ZOG9R5f0xC4IdDGSXx6OdZXqT2Z6jbGmrpoPqubCSKeJxdx?=
 =?us-ascii?Q?6GeC2lHBLnQuN8S0OhguyLymnlvu5c6FpiI2geLn3Yn1LtQw1YiuMeq6rQlD?=
 =?us-ascii?Q?9+QHUU5igfkzeaE6lwCYopwWUtFhAn7JSPYZFDAgIGQkPc+8xy9L0wRsWRWX?=
 =?us-ascii?Q?H3F9dyAZmTQlm2HCRJFe6tMMlJBBse796NV1KY1dVTnyJQWF3usMMxqqPNfQ?=
 =?us-ascii?Q?88b/pNdGKOXSGB4kIa6J7NkE6QCaJcOqW3VaNwddzY7H/zyqCncaozKs2zj0?=
 =?us-ascii?Q?DIBkymAk5ywB4KOakVYSeZ3Rw45f8IVQFBdrlZCQSFzeEcEidzFOZDCMALZY?=
 =?us-ascii?Q?ojSJ9MkyM7pICr8PFiuZ0+7EQ7qrFNwiGuwqftWESiZ2yDZdO4Y+fTjrA3Ft?=
 =?us-ascii?Q?+f3+h/RPgQzrRWl3urnNKBOZlbqTFby9wj1jECxIKgnAgL2D/MBruividRXN?=
 =?us-ascii?Q?WmYkeCHHV185WyoL1aqxfv3hcstAyoALnUikwIzYiQT/6Y+d2Z8u3hPfY4hh?=
 =?us-ascii?Q?9H+hTmkSYswnqGe/ykLZu1dQr/LwObqEmg3no7AiJ6Zx8JiGQrSf9KZX/lD0?=
 =?us-ascii?Q?TdE8VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afc443b-072f-45dc-c655-08d9f6a06d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 07:45:13.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTeWpfKhxYW+sZCMOstxgn3Gn1YEKaLhs3pfzWlWGonW0m5QevBujhtw5prWPQTCwIj+wsfQeCoAa21XJQqNFxbUkQcRSrOwqTLASwx8CPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

> > I found the issue when testing DMA with the UART transferring different
> amounts of data.
>=20
> Can you tell more about the setup and test cases?
We had a loopback test from one uart to another. The test checks the
following transfer lengths (bytes):
1 to 33, 2043 to 2053, 4091 to 4101, 8187 to 8297, 16379 to 16389

I think 1 to 33 and 4095 to 4097 were enough to find the problem.

> Also, which version of the DW DMAC IP is being used in this SoC?
I'm still checking, but it looks to be 2.18b

Thanks
Phil
