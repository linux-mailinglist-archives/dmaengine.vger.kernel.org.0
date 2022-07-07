Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B835696F2
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 02:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiGGAgB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 20:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiGGAgA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 20:36:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1DB2B;
        Wed,  6 Jul 2022 17:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRzfvVNgiPYREDhg2jK1SOWI9j7LoIhE7xoQYl7kANswMhO+iYhye7/OEGGDjf84LGmkVXBcNztvVYXYRYYVGWLrN2YC8omvCzLueUU1EOu+mATJlBxoJa3QSm+X+7P24svbbPES9iG6pKj5QvlFnhtkmT9bgsG9yZqZDIaN+A+hYke2gyQ4s8rmSgnmGVlc/rkEfrLsrJex4m+4DDwBWpxOBwtG6zEJJRGTfaXynPLWlrfVTu6XkTAKu7kwp51Kn67LHa5NsayilqOqfsVkd4P201abdOk2K72G7vN5UPbEyDb5SwHzjRhSek0jD8szFuuEjq7WJe1GOgjH+7PryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdmyVa3+z8kgSlXNnn2g7txz93DMIWtPehWLpZxEPTA=;
 b=X4CjBDiAX5ivYa2ZYr1WLtXF3Y1WfCcVjqTSKrxS0VMtYiGaEYDrkkQNHc5rwLORvTChvzoyXYygQsT678sscw0LoAsg+KrjVeHoW7ThQTsbVXu8K/Q29W7Qvyjqz+6ho17WQmkhmE3B10Yf6iJSGf9p8ffaQAJ2hEXfj1jFvqVueLbxmU8Baierr0U1mvOLmUUh5ueSAtZaUn9Y3ucAdqR7dY9EMapS0Ue2hqSTNVmREDynnKA5FIY5ljz44R9vnUfjc4dkWG9rdZw6PAI54SHSt6HUjecvfPXmQuI9Sbc3Y30RsICs9Oqk33KjpyfrOKWZPhdLD6jde0b7sQw2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdmyVa3+z8kgSlXNnn2g7txz93DMIWtPehWLpZxEPTA=;
 b=lZtoahxWZyDppZddcyCXT7T+ptcuJDjKilX4v0zsPICqnvES+BKH9HWocCMaRHtK3hO5k9JVawUozOfphi6xePvQTwOMFHGJntM5SC9/vxzkLyDlJ8G4WdEYiy0kLF8hEk41bWW8X2EGVgSNHliL/DgOurdv4/t6aixKj634Kjc=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5513.jpnprd01.prod.outlook.com
 (2603:1096:404:803f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 00:35:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 00:35:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Frank Li <frank.li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic
 io-64 methods
Thread-Topic: [EXT] RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic
 io-64 methods
Thread-Index: AQHYfKtQgpemW274PkqGO4tIUqvOIa1w+AlwgACYAYCAAKi9cA==
Date:   Thu, 7 Jul 2022 00:35:55 +0000
Message-ID: <TYBPR01MB534114729095568324E44B70D8839@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <20220610091459.17612-20-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB53418C1BC8791CB6D068A177D8809@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <PAXPR04MB9186551C4A12F747C35784B288809@PAXPR04MB9186.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9186551C4A12F747C35784B288809@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a43d008-8c28-429c-8e91-08da5fb0a772
x-ms-traffictypediagnostic: TYAPR01MB5513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y6VK4HkLhsPuuxMB+sjB2Iy/vvt3WVQbXICh/d6mb3jNav+pSWWfKdkvtqbo78qonJYtqAjoVBI5TBazy7Bsbg+Ayvtk6W+e4AqTdnEzDZZwPlC7ASmgpnq04Ub+G7/k+HB7JWevBbaBT3YtrpsrVLGNiM+Q+zJnmWJybgCyiAJyZO/Tndw3XPe9FvSlEDCSsuSdNDSCywrGS+G3t/gnPhBcsAOhBRVPi1O/4OScH1K51XKakCoQX+m7l1RS+GsYENR4IKcmMAk8lSotSmxKQzStVgT8Tg1BIqtAPBObIKywUCS8GBo3/sBsRXWoLUrMOz6tHTm0QQEI9UwXLvRJiTCQvPDBe8+7N9WRN6GixkUD7XAS/N5dVom3VZ39HNltRBTz+tzQ6vhq5mi3pVN3Kp/BW6XiHyqXfOeeDbbeWpiG1sm1z5d6H2rl+rmNpCewWWqJI+flfDSSuD3HoasZQF4M/CsAzkrq2tNVu/9PIASFijWSHzisH1l6zcACYatrN/1Wsfj2SEc6Y2OHwcv9JHohf9bbh5Xu/W+y+/Hox2vz7gAk8DciMoqdI1ZrH5+gvQIFTZqt1PLnFCPXnGcIFPZzev587Ls3DBlPKTYE9BiLb8XbM2xQRsYC72d+u7uTCfgyOJLpMdUaZkPqz1AGFGWlR9PcUcoXLQ79QlUYVo7ycIKsIRmvv51u8pRNlDBx33IHo9sBimPufjHxRJdU6JCLQo5oD7rale73N3YZ6MpgzZFfqtk65qqz2UxCBc6B2BbAey+/QSr8ifsCToCRFeBtaPIs9sFlb1pJVuPP2mjDGtI6XLnpdWIxCfUl40zh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(478600001)(8676002)(6506007)(66446008)(64756008)(316002)(4326008)(66476007)(66556008)(66946007)(76116006)(8936002)(55016003)(71200400001)(54906003)(110136005)(7696005)(5660300002)(52536014)(83380400001)(7416002)(41300700001)(2906002)(86362001)(33656002)(38070700005)(122000001)(186003)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?G6XWdqy15EtXxVVO5IDC8lM2GKg2t9AdZKSheW/mO9AcZ8LmnBnOeOP2ge?=
 =?iso-8859-2?Q?7lY3KACOWqKcRXasOlWY7tszdEkscPad3mw1pd4ZgZaGFbKxyWlnhhr3M0?=
 =?iso-8859-2?Q?1wtqQ3JXMtuS5dSa9+eK0C2yx0CWr/xJELgxOFtR1f5Iivcc/VaxS+9C9P?=
 =?iso-8859-2?Q?vEvJD00ziZrxlCJ8Kf7VixkoDwGYusOMijMhSyhvJw3xAKByvItaoaxTYd?=
 =?iso-8859-2?Q?A/FB6tEA61jpo+dXCcLwafRUsgVqo7jfxGGygWCrSxLKwxQ+oOnPG5oSc6?=
 =?iso-8859-2?Q?YRjGGeu5GZB4KS5kXdOlSI48wHCkO82Qgjk+t9cHHMNdRnqdCfHoof7lDU?=
 =?iso-8859-2?Q?kHYmxUOJxtY8/2ecsPri67CcGMJeCtS3zyE7yUE4RAi8c+QW3q2Rj0EmpL?=
 =?iso-8859-2?Q?QKpjOyAwviPgtcnr3bi0rD8xRRBKZoNfl5cONcKwjwpCmuVSCYnxahXTaY?=
 =?iso-8859-2?Q?m82XScOl0T+MlW+0Bwqui5v2Whwm1oUA00dVXvyTSMzB4su/fSswn7WCoi?=
 =?iso-8859-2?Q?ItiAffHxv2GlWX4rPxbsVNTFAh0/UhWTQSl8xcjCWDz2seLiZaGqTiujWK?=
 =?iso-8859-2?Q?WHRY4ySGEeKrSzIp98rwD96cYLZJ7SXt/vlT0r6aIlOEl15USK73egOsBv?=
 =?iso-8859-2?Q?lqlswZsH/0MimxGI+6t8sDP9dsubfCthus3pQk2kq4m3nRn8xfX8YbiRfV?=
 =?iso-8859-2?Q?AaMqchvJIeHj3TDt555p0vuydsk0tNl4NDHxrCOCaFOei+Q0NIZ6Y42XvC?=
 =?iso-8859-2?Q?JKXCRtHjNnM4zC3Qo+QhQTzhHAzAbS2RrEidav3JAvr6RgWVPFsW88UdkT?=
 =?iso-8859-2?Q?jRSmne7mfjGXxf2nERcXTXlpoEcjGwO8J41jSyKA3rkB32WuWtXLdQXUGP?=
 =?iso-8859-2?Q?HnBuAzZyg4OfKgYuykNv7Px3M8Av7TnWBvOMqFBy3qU3qbuAjYao0DZpnr?=
 =?iso-8859-2?Q?NZVPXThbsj6g6xCYlF1JLG4dIL2Rp/g++fc4qoGSdg8GDV7BddN74b591e?=
 =?iso-8859-2?Q?L5GrUuUIwwr/kaB6GhtCxxbgmELBBahtjDA9sU8J/xgjre/gHnjByu9RWy?=
 =?iso-8859-2?Q?nPTOH31iIq0mekt9tDz3H9SUBBjd8tnENPILHXHMlh0sregOZaJ3Wk0H/g?=
 =?iso-8859-2?Q?f+FmsA90e5KJO27u3WHDXLfVU/mUWRLjrVzSBiQzWNHd9MjcHPD3ICxAlf?=
 =?iso-8859-2?Q?4ComdzrSKNU9CwslWf6q6m1PIr0eGsCGlYsnVyTgvDm3MVQPYXJczokGhq?=
 =?iso-8859-2?Q?z86L0DwDZPHMaBcild/EfgF0oz4CyV132L+6fRCrDzmMQugZqn/g7O/JON?=
 =?iso-8859-2?Q?MDQi8Kwq1iPvgvbxAUGw9GxKLZ7TOChtA78gX2/+23EXddlt4r/AxoIBWP?=
 =?iso-8859-2?Q?JY95+BlZSdE1FxYYJUHU/X341SwtyDwMrOtT4y0tv9NItzqNHpuCIZSy4+?=
 =?iso-8859-2?Q?Va3NYxIwPNUvCRVQ1FXo4QtsBeif3bzJsNyvHJVshvWzEMgcouowm6jvhl?=
 =?iso-8859-2?Q?oyDg3L+H5CvyZkqbySWro1l2tiTR0PRB3TRvUuZC19ao2srnF0HO8y4WoR?=
 =?iso-8859-2?Q?tAxEUOphNVMln1Cr4suUsXqBCfs5EOpwtw4j6P0fAySufVKI0hS1SP6/Tl?=
 =?iso-8859-2?Q?OX94EUOuYhSZxk7ti0VQDOYlu6Zl4LsXbwJ/Ukz7Z/dh1c4qHUU9kE4tkj?=
 =?iso-8859-2?Q?JPy6UlqcUvd6T3foj4dOKA7Jew12+mVQsqmBbpkX9y5v5W7oYLq88sqcy1?=
 =?iso-8859-2?Q?gDcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a43d008-8c28-429c-8e91-08da5fb0a772
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:35:55.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHwidnuEMAVPPmDnu8EgvPmOFO0bwOoNfJQnyk/u01FpSeSbeOCvXLL4x8ptFBMJAWCAHsRRZra6hP+oOXwWVrAfxFtazU2NjZAI37u5tZgmhFsuv4n9ME9RUKsIRchu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

> From: Frank Li, Sent: Wednesday, July 6, 2022 11:29 PM
>=20
> > > From: Serge Semin, Sent: Friday, June 10, 2022 6:15 PM
<snip>
> >
> > Since both codes in #ifdef and #else are the same, we can just remove c=
ode
> > of the #else part.
> > But, what do you think?
> > -----
> >                 #ifdef CONFIG_64BIT
> >                 /* llp is not aligned on 64bit -> keep 32bit accesses *=
/
> >                 SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> >                           lower_32_bits(chunk->ll_region.paddr));
> >                 SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> >                           upper_32_bits(chunk->ll_region.paddr));
> >                 #else /* CONFIG_64BIT */
> >                 SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> >                           lower_32_bits(chunk->ll_region.paddr));
> >                 SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> >                           upper_32_bits(chunk->ll_region.paddr));
> >                 #endif /* CONFIG_64BIT */
> > -----
> >
>=20
> Latest Linux-next code have removed CONFIG_64BIT.

Thank you for the information! I had looked the PCI repository only.
I confirmed the latest Linux-next (next-20220706 tag) code have removed the=
 CONFIG_64BIT.

Best regards,
Yoshihiro Shimoda

