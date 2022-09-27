Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731855EBAFD
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiI0GxO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0GxN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 02:53:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8E9A6B5;
        Mon, 26 Sep 2022 23:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2GQ8oWDbq2T1S9WveQ/tZKaI1Lu1HlJrv5WB3S4D3+k0sWzdi03GTSuiPxkuZtxS/O8sMAdBcbOJneWbrMy8pOT9Bb6HOlITMsNN5uZwrAS7nR5Ic0gl9vtcPVYo6r7gSd3y73THkZIYNdPXtno5n1sENDVfc9+ew+Mo53PClk3Z0xI6QQ0wJ5SX+4pj1gQzdpjHnHE8pnt0It3pvk1vs7hvAYFWev7YGBQMghpeZDE6ac4iy21Nx83XcsqS9y8KCfdLFbk0tmBqVv0rNkVtxG8ptuoGxl4YTANGunWFppXmu/zMbXtqlI4ixL9FwIkbyCLRNOho7Ssk9npse7RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk0W7fXndk++tQoWH0PUWX5epPh/EoV5iC/SLJxVY04=;
 b=MvdB4liDyCtWGpuJ9IGCsqtpAtzg5CX3Db4muzrfrJJU26LpzmnqtJQCPRLgHFjPINTHwNUE0FzmJEnkWPGpI6+eHJ8u6ptwipJrbfeRZxuhgrZLEYbEgx3TnSGdRuEH1ShPmZTP22fGiQ+ln9z2kjClHQxijIsnjqd18pV2qgfqNa4KDQbQ5KOeZFTR262Mlpwq67aoibX7gWsYSAs2k2V+8igltPQwMpZkt1VLFvvg2Egc2uMPZUJEWfzZdtqCxg/x3EqmCYjAE20ZuiZjLm0uVMmSfpDHfN/74TwsaDb6/wMYdaVO2qn5S6bGrQGIXG9tqHknG7pK5CJcr8KRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk0W7fXndk++tQoWH0PUWX5epPh/EoV5iC/SLJxVY04=;
 b=amaB63PgyahFeJAyTEvYb5i7UisM2t9VFWygKb0kPynRx8Gi0HYLI6b6Lo/967t2se6eVC3TWGIjwXmJV867On3HnFg6VMeqojewUbtVma0dn8kinzg3l8C8ojqiXT2kAkiWQIyiwvEDs5OCHEaAvS9L3k5IKyIH+uFIXWeWAXY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYVPR01MB10652.jpnprd01.prod.outlook.com
 (2603:1096:400:299::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:53:09 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::2991:1e2d:e62c:37d0%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:53:09 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779g0 support
Thread-Topic: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779g0 support
Thread-Index: AQHY0bkn/fJ3iqk2YEe+j/nPlR5OlK3y1+MA
Date:   Tue, 27 Sep 2022 06:53:09 +0000
Message-ID: <TYBPR01MB5341D19A7EB469F297905173D8559@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
In-Reply-To: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYVPR01MB10652:EE_
x-ms-office365-filtering-correlation-id: d33ef6b9-903a-47bc-37ea-08daa054f050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64Ri03A3w/CmQu/H+xZXRfTzAideZoOcojBpFKWkQ+NmKSmiEqsFNHswef4NXqhvMOV188o7ommDHpSF9gcKVKDWY8eCj8KaIUC5jOnpx1Olz2l+khVIVwnnxEUooK0AWsRV1DE0QPowfpwwY+BWp+nlHpP1eVZ2TpvGqxLpdr1dFVqhUiK4An3hDNxAzybwlEL8sqoW/RPmPcrlsmDz0p2g4+zLW0TEh7fvU5SfW7jFPinSgXwTgTxOmg2aDzX3A9huExWchANNAQMtOcQZ3FWeRMqnpRjg7f/vR+Itab5FI8ABzWkBDpRkd7blITgJCo4rUhBAHW3nRwdzHvZ8rq++JihZHZlMZdO8WUaOGhTn4Iye+5h0CzeXWyvrJPRF4Mr6bU/H1gHYDL0SYtYGXz+DHCsaICxQ3nMl0YBTxgAstSFw+L4ldIX4mXSfBYdeEoYIstTsxj/2DVcJm1iQbQNPqMsy9uilajnDWZEeCM4AYriqktV9wFbqR7t0UeY+XqxxNld9hIs1bQkD4o7QD/Lk1DaBtpn7ZtdpVap1LCnerRJE8LKtLM/idiAGs/52o0tA2NVUUcUJBpOLoBVzVXNi8UqtaNWBtRCHh3dxmJ6HmTS6lnqosbEO+vGTfi1jpUSSXv4+PhEfNs6ektRgZuJcfahj0PV+7h1mBgt+9Myp7kfQHRtxft1m8Y4R0ik/i5Ntg8SruUaYF8m8YfEKDURjCPPvjVCxtkbn+/ld6D5uj98SJU7kmBapej6B2sueJG01bSmwE1mVLbC1rVNlIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(41300700001)(66446008)(66556008)(64756008)(9686003)(66946007)(4326008)(38070700005)(76116006)(66476007)(186003)(2906002)(86362001)(5660300002)(33656002)(4744005)(8936002)(52536014)(8676002)(478600001)(71200400001)(55016003)(83380400001)(7696005)(316002)(38100700002)(6506007)(54906003)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49lpNCZbNit79IGvy1isXpjncYzqP6lKP8DJm/mQfG2W9dqymhhoZgHEoVgI?=
 =?us-ascii?Q?g+tcLLWPeqfqIJBxWCtWamFD7ZkZ789+FqWPI5wthgKeYvkVC9SwcSCsFx08?=
 =?us-ascii?Q?1Db+1slGawNrLPz/jvVegM46mDCNXU8d+T54aOO+mpeK1SFffXD3rXGr6tlq?=
 =?us-ascii?Q?+sQcmihKs5/mF5CirblpkioflOdxrGdVHoETE9FMmAmDqX7NngNNJszgTpNi?=
 =?us-ascii?Q?Hwl4BSrTl+tp0k9fKPgGTXVWgxviYS2AFnIL/3GXzawQIGE1BzG6guLlYhXS?=
 =?us-ascii?Q?ZkYaEfdYmTtaYO6kb2a4qAtr85gq5LE1La6TqthM2WTh4ienhcCXxFFtxWb+?=
 =?us-ascii?Q?EbzRWi44KovwlDv+xTY6QidIokjS0vdT2eZ7Sf+mBP5QDE5tvFpkHVBFdWxG?=
 =?us-ascii?Q?un4wxy7lLK4I9cxR1QpaYSsamWOSjvy9YRYhKXK+iRmpCuyKsbaoQSwJe8FT?=
 =?us-ascii?Q?KE/1rxz4oEowMGjR3IQMLaFB4wqkUL/iqV1gY1YJAuyjXEBiYB/d5E5x4udK?=
 =?us-ascii?Q?W2ZThiJcS8IBF+OuxwoaJMya24wLphv7QKADgkdv1nYBD1Wo0IBiHPiwb242?=
 =?us-ascii?Q?p3IsIl3AhQ5Q0pKADbFWqdordcNa5bVe/Di4TCeVZVoBJMnji4ZtbJ9eCPGi?=
 =?us-ascii?Q?bOUkFvQc7C/W8MYvBU5AElDFDD/k5UXSHwqAHmjKSZ5rwYMrlWc5OE21b9Ov?=
 =?us-ascii?Q?BrrzkCcIGjJaDd3AIYhlI2/gNg0gkWYzFvLlI90OvRtiNoDEsH2JkvTOGGpo?=
 =?us-ascii?Q?n1rF7mIJsqixi+k/XlG9pT40OdGjLongPuliWdcSHttW51mFCyDIJhhfzgud?=
 =?us-ascii?Q?dOWjB2qHiZYBE0RstCN4Gnw05bBPqKd9boseIFhh3fPqsi0sexaEGBLow4Dr?=
 =?us-ascii?Q?73a6WKTfSWzIDmLcudiYYFh9QYz4/Ftwv9Vu2mgmahF5851G4tqtHU3b8Gx9?=
 =?us-ascii?Q?Qhlq6Fs3FX81jgy1x+pW666WZybNpsfQbD01koGuy8tWeTduYdMsyqaTHY/C?=
 =?us-ascii?Q?XD468j7lBsObG/jhal5MBhmnd6IKm2mo9z60BBcrC7q+MEXk0XmX++U/2nm/?=
 =?us-ascii?Q?15Pnz1emN7gxLgnGL6yOowBDp/dkNG2Wp1t1aWWAdwFZ7VoWCPbD0AJoEirY?=
 =?us-ascii?Q?Zik32CPRUGZVK4nRqundZAYLF+0wpkJSoezFzv3avJb865H7nVhmVB1ISIPZ?=
 =?us-ascii?Q?/4PMHMMMYrjv9Hp1w6gm6CAsyDBeOLj3ebhLoU0SWoP+1olXw4oYgCqGAEgR?=
 =?us-ascii?Q?3MgMKla/kaiF9R3rtS+4DFgPEe04d0pX7NzPeEpNGsIuHAOLv19NhfdttM3b?=
 =?us-ascii?Q?9qVkVcMrgCk0KlY/mqIf6J5RNnc5KiiO2UZCZ5iHrScyDE7i/dLEgj7lHuEG?=
 =?us-ascii?Q?q5bp1hqDfIdtQyZSEjzijL+GlqjnDLTZK5LyB0k3vyGJW/C6VEvi94H/vXMQ?=
 =?us-ascii?Q?IU0ipCjO3RB7Hvxs9fLvCv6FyOz5tyPKHzptDB32gg51UFAYruaRVj7XDqbZ?=
 =?us-ascii?Q?RVslYQnDSzlOvjyKAa9c95GvRGKm1qcORs22b+ms8joDv8uHHlb5tP/hVFMn?=
 =?us-ascii?Q?xfrybA908Tzp+Z4TSinlDUdr/x/KSkd65lnQFAH7yqvypNvWebhxaQN0D08r?=
 =?us-ascii?Q?htDb3W0n1Dw8QrfRtgQwny3VG7mdhdIM8i4W3ktCj4h06XUbIGB6rprsaz8k?=
 =?us-ascii?Q?+kFABQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33ef6b9-903a-47bc-37ea-08daa054f050
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 06:53:09.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dhm/c/E/KJFOTol95oWHcUS/7bB1C9xkcLz4qAJ3TRg2BHmw5ttlvLfWACgKB9S5G2pVUGNpjKpgn86e5sxS1HBFUVoeMYbrWjSXFPJUo1WqpaNme3jVETiVHwAyn5Bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Tuesday, September 27, 2022 12:03 AM
>=20
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4H (R8A779G0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> index 7202cd68e7597dc2..89b591a05bce5fe5 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -45,6 +45,7 @@ properties:
>            - enum:
>                - renesas,dmac-r8a779a0     # R-Car V3U
>                - renesas,dmac-r8a779f0     # R-Car S4-8
> +              - renesas,dmac-r8a779g0     # R-Car V4H
>            - const: renesas,rcar-gen4-dmac # R-Car Gen4
>=20
>    reg: true
> --
> 2.25.1

