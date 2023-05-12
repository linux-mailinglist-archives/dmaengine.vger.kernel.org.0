Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E361700451
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbjELJzw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbjELJzv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 05:55:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7D618D;
        Fri, 12 May 2023 02:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNNRJXvX82a4dbcyqSx/qdlpVxdGFBd4wJF8ABWFalKmZwXwJGj5ktfkBm8pt72u+dcyCq9P4D0hPhetorNq1fB4EzGE8AVptOL5hF8FWobX8Ngp/8sIxvFtjApvryMMMydgyDQpGYzGTlaQv4jplANT577O6yHkCR5B2bC3aRSU4xmtPCUUEdoX8O5p4u+nds0d6ZVVItM3Rt5nE+rGROoddikPTwkcp137tHy7xeUSFfdQNOyrBeS887EzoGmnytgn1+DcyQiBeKv7CkPZ5EYJtRcn67svpMV4AcIy2+Y/HCNzpLv9Yd/UPSVinzACiCtLZYgcRUVprKmzBOD6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNa5nx38Gt3DrA9JXfHb1Ow7w7lMEc+GqnOeg+H7hpg=;
 b=hUUw61DeSGPW8WgPSTxV3q9K4iGP6pyBQhdI1F7UiDV2Aj8+rZF58n7aziqsr00u87j3vomYfOH+rJyWN7oxZ7GLh5/hW4smYLHEqEHiwDY0XawM2ItIW1jpjzX49ADM1q9Dgh5Z05+fwfenE3NLhon1gq221Yfh3f0MKKTDAWX79QCNmGsYHmKBylZ4LEy4EEGYcgHJqNurE2nKeu6TNoHTWgLTRzAjJyPZaReBEoHtkUVXQDbxBVNz2lbmDfVtBB9bY6/07YdLEGC21tnHrIh0HhEcWe3rCbEezv897ei7KTHA/G3VIDHLl96d5rMvafnss8Zuuq27pNzpJYJPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNa5nx38Gt3DrA9JXfHb1Ow7w7lMEc+GqnOeg+H7hpg=;
 b=NGovFZ6vX7XOLtwYuPdBwBuM6tScZU+K9h2xAWw4JSPJbX0A5zJxi4pyBQZH3E5gxJX8TmT7yCzre4uqlI/OBfeou7aiXcveKwZedzIksejga9b5pFZA4Uv9BuiPFwA405s5wND2nGdgouZt3bkxumkfvflC1yw1nxsBtASY8YE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9669.jpnprd01.prod.outlook.com
 (2603:1096:400:221::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 09:55:42 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 09:55:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v5 01/14] PCI: dwc: Fix erroneous version type test
 helper
Thread-Topic: [PATCH RESEND v5 01/14] PCI: dwc: Fix erroneous version type
 test helper
Thread-Index: AQHZhDwXWotVTkmgvE+ml+mr3l8EK69WZn3w
Date:   Fri, 12 May 2023 09:55:42 +0000
Message-ID: <TYBPR01MB53411830C969326CDA5E9DF5D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20230511190902.28896-2-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9669:EE_
x-ms-office365-filtering-correlation-id: 28648ee4-1180-4355-a7f2-08db52cf0cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogsR62r9Q6c1YE+pImWjSnHkgWPOWvsuTHzkWqcnFp9u6hGaa7iVQRjyvpcgn4iso9k5mdIx/Gdm+CPgZB+0tmMSHbQlR0cFAtro1Q/2u3uXC2uwo8ETQw7fTvKadumxboZ2ejNamcv+SVt0lOEtuWeIf7yPJKBJSPZRkzrbU30+f8EQAKvjXLPIhMMEJDjz869ZJYhnOQuxQNp2GzOlSi+spSfBvo+DvZxzaOKvXM62gZFqtjWxh7grDDKEsvMMf7UPdLsKjMmKwG5RNwjliKSUMZ5JDbKtUSRLGNUBn2N7ocFtXGfiS23SHKIBLqvm0c+FXn/qOP9eDvEmIDZBP11D3LkdNWF3uz/kbKyhNfphYwSkTEedbgy9nUM2jIs0O6GhcilcOGl332nGml2M24VYC6kqi7sWX3SOO08A6oL+LtPVo2zttdnQ+tCl7F2GEX1SPYbbN92AjPwp9Sfg3F9mCO8ex8u+j1zaJLZ5nZ1KDtCoY/B7kcPVE5byBR52tE3fKptiEohB7QhueI66yLRHMPEcbaSHVHJVPSIhjxKTVKPGr9nnKuR6W6CUAtPsdFwO3xYS4kdPZdGwHX052tVpG5D3dwAmaOx6jLY9h/skGqNA6gvmbg/g9cRkf8sJ9HGBiaMza6ghdoxveEqLuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(110136005)(54906003)(71200400001)(26005)(9686003)(6506007)(316002)(4326008)(41300700001)(478600001)(7696005)(8676002)(8936002)(5660300002)(52536014)(7416002)(86362001)(38100700002)(55016003)(33656002)(186003)(83380400001)(122000001)(921005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?UUz149UXA4SccS1ja7mNJ6WElxvuGPCGVeiJL3F3wLEod4C19NFZNoBlnS?=
 =?iso-8859-2?Q?cCSIAkDKSJGiz+96l+Kt3+y7fltTqaTi75ne/vOBJLylh1MqAHlFsyX2EA?=
 =?iso-8859-2?Q?gLpVDloBJe220Ov8X87gHzwxgwRUNrqrsAeLpBY9mmcd1cK6uVRbJgW5NH?=
 =?iso-8859-2?Q?78R3ApLObK1446QAYCW6VQUUCD2CUvaev6za8Unjzux11l2CEO1le/ajSz?=
 =?iso-8859-2?Q?H4gC4wZRPRIc/ZKmEFQN8H8TX1qy7hYn5D2c9VqvAGDZ1CsG/evS2F5b2L?=
 =?iso-8859-2?Q?bL3KCz6PeIIPIXywqYHfkjR49J+Xg9VNrPcp9V4qZWFJc5kaWhEQRKEJS6?=
 =?iso-8859-2?Q?7BlmfXhvItRdlxicf+Lqb4SPxy+UwyOs9JNzF+90aGdhBNmeBURdnopoNv?=
 =?iso-8859-2?Q?zgBjXqRq25vyCTVi731rScIbyjt1TFrgWJapKg3EQK6+dZyIrzJEZHi7DW?=
 =?iso-8859-2?Q?NVyWBz2UUXyTMPMYVsaXwddFYSVXXYGcjKT1qxNRhVfIGvQYouzhFZAXBJ?=
 =?iso-8859-2?Q?i4089YRW//PnarYMUMNEi6fg9ygqeJzhCNtjun9sR2Bwif19MoQ711euaU?=
 =?iso-8859-2?Q?rUza42m11rwiYJK/zPK2YFmehoKOWGOmb2kUK7bkAGwQWDs+reJMxcIss0?=
 =?iso-8859-2?Q?nET0aIgmJ6PlhjuiyRzdLqsN/t5d4mVODKBFC9BqwgGwSXSGifwipuzEdN?=
 =?iso-8859-2?Q?VuSPDsfmTxpqQ0VpqvbSKBDYdbE+AVJ6HrDB3r304+xUvUDuBqeYxeZnCF?=
 =?iso-8859-2?Q?JFDCQL8oraRd978bLSvqzU8YDA03ZtCXRVPblXtsLNArHHpYJ3rDiHXOKS?=
 =?iso-8859-2?Q?bRaxY03zdrddy4t8QPJWUQxtYfXpBVkTTgMFqbWc1zN2mulLFgMcJc93XK?=
 =?iso-8859-2?Q?mlzUEJ1DokpGKxPzJzUnz78XBmuCxItuqexMZW5w37BMRCe37LjD6kV3L4?=
 =?iso-8859-2?Q?0H1yGRafjcny3hM0EaNX5LtMsoPscqOYAdtjKDWc+PDnKGG5naGz6lDwao?=
 =?iso-8859-2?Q?HHDhTQkYUUBVBkSYo3TY9dLk6Gm7M1No+TVxxsSG62PQJV4fPNM/0gCxAm?=
 =?iso-8859-2?Q?RZUZms6BHJta/55wuYoE18GLt9M6vpPplD7YiFFgpb19ptkNwQ7bZHKNUy?=
 =?iso-8859-2?Q?7N7q6mmI8P8f5cSz4bCrsLucIQ3OUDU1x8hG57Zw5LW2j2iLRQqKP6Lz5l?=
 =?iso-8859-2?Q?PzVjFTfRnFPFV0UKpGCZKniV15Brmo/1qMnJYggC7TFvo5DGgUpVtIGIAZ?=
 =?iso-8859-2?Q?gWMXK699EEMnvIq7FS8EVs9iRzxZrn2PzZLlLazNkFChIjnTry0hgsnxYI?=
 =?iso-8859-2?Q?+OCiihs2+CJFNfEiK/8pfYYmkCKXD+ppdZ7jCHfEDO/Z5pEU2msCYgDjLl?=
 =?iso-8859-2?Q?loN5JK248rOwQrdTmn/wSzRkgLdLvBDdkK1SqzH2FXlz4INcIhGaxD1cqW?=
 =?iso-8859-2?Q?yl1lm1QRPxYn4oHUv01/g6Un4ip6YfTS8m6DApnXO9LivbBCMA5ck2l2Cy?=
 =?iso-8859-2?Q?BXUAOLvDQgPogUNd4CyzhIXYW33uc0YGiF9SSJdL6Voxa5eb6YKi8QTL8p?=
 =?iso-8859-2?Q?uoTo4g9OiY5+Q8SV3P/Jj0mAY2UZ3x5XaK+23NX5oHTD309yCHqkNG1KUd?=
 =?iso-8859-2?Q?g6kK0A4g5hF/SeaVEcJtoW6QCZJ7fEncN4ASF6J0tLlRe4ezYL4dmMiA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28648ee4-1180-4355-a7f2-08db52cf0cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 09:55:42.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFnvWs3oF7ULEzPZDgHY8bL2HirNj0bXeuA6cUd5wLwwD/65tNLOBTC1OwZ31D4LPqU7Tj1mjivAlToEl2ATPLE0ev4YkT+sZ6/4r89uaCgATmzRDo2sntFyAVY3Vw30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Friday, May 12, 2023 4:09 AM
>=20
> Due to an unfortunate mistake the macro function actually checks the
> IP-core version instead of the IP-core version type which isn't what
> originally implied. Fix it by introducing a new helper
> __dw_pcie_ver_type_cmp() with the same semantic as the __dw_pcie_ver_cmp(=
)
> counterpart except it refers to the dw_pcie.type field in order to perfor=
m
> the passed comparison operation.
>=20
> Fixes: 0b0a780d52ad ("PCI: dwc: Add macros to compare Synopsys IP core ve=
rsions")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'm not sure whether my review is useful or not, but anyway,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 79713ce075cc..adad0ea61799 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -37,17 +37,20 @@
>  #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
>  	((_pci)->version _op DW_PCIE_VER_ ## _ver)
>=20
> +#define __dw_pcie_ver_type_cmp(_pci, _type, _op) \
> +	((_pci)->type _op DW_PCIE_VER_TYPE_ ## _type)
> +
>  #define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, =3D=3D)
>=20
>  #define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=3D=
)
>=20
>  #define dw_pcie_ver_type_is(_pci, _ver, _type) \
>  	(__dw_pcie_ver_cmp(_pci, _ver, =3D=3D) && \
> -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, =3D=3D))
> +	 __dw_pcie_ver_type_cmp(_pci, _type, =3D=3D))
>=20
>  #define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
>  	(__dw_pcie_ver_cmp(_pci, _ver, =3D=3D) && \
> -	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=3D))
> +	 __dw_pcie_ver_type_cmp(_pci, _type, >=3D))
>=20
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> --
> 2.40.0
>=20

