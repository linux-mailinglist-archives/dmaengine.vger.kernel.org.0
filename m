Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA53A4E9A
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jun 2021 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFLMTw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Jun 2021 08:19:52 -0400
Received: from mail-eopbgr1410094.outbound.protection.outlook.com ([40.107.141.94]:9920
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230470AbhFLMTv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 12 Jun 2021 08:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVRuDFcJ8B6+PRJpyb3K1yEsuJlb/FqctT3LwA7ybqN/v4ZwDFcVrqsCeDMmRwDaiJvJ0Vqxu6sgFXlztr9VV+YNnSIW/X/bUSmAFiwDijOAF0NjKKeCVQnU8+TeJV2lG/HGQ+8TYLWx65Wr7onm56NuvVEPp2+cL9e1c9Pp9Kq/K9H8D29kQpX0Ti3I0dKQYlvfZ8W/tTXB5KaP3JEIyniDXiM7OOZTJrX5aWKkbzvLMoZ9GI8T8bKmblbk/wl5mYU5+OFqT4Ba37u7E8m1v0On/R6Z6QCLjzS5pePaBCp2+55jB2bD6ZT/pM2FstUQqndJcLZ6J1+u070Z6Bzv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uoA99zVu2HtE7wj+RED9BbgMzaTc/KNBh2WLRMF1js=;
 b=oW9GL5vqJ0HuG+QgSup1Oljgbp87Q/4H8fi27CNPOrUTGzPl+Uq8PVj8GUwbMW6w/X1NOFIeC0xJFwgbR7ROaBTOKvclc8JLleMYUNFbkqiuMhGW4nYYaoAoWVv0puRbeaacUOfpYNXg6e5GEHLppCvixzg1LfyybL6jUFe35EsD6H3Ywrstr8Qg4j5F3hUImR0QWQ6rNIcfgIp4Sx0ZhBZeUm6+wk4g6kF9e2NHpZdTSLEAueHgDENow9FYwW0mKvR6Uc6lJhYC7nITqRylfne7igX2PSNmQ3ebg8KSuoCTuADnMhJTK7wfj3AiDD9dCnIy3uhGRFzL6WWxXYBvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uoA99zVu2HtE7wj+RED9BbgMzaTc/KNBh2WLRMF1js=;
 b=Vuqsd3skB0hxhod+j+Ptqs1ru8zUnQc5zazUMZ2D8DzhjDyvVxzSNDMWHxZy9IHci8Gm+IgMJteybbJM6nAvKDEW9bDOtuVLAej481n220MAIDFnIie7MFt9dbAfbRBb2xor9aTH3+FS88mDBA2peVjCS5sbnrkwLCv1ItijKtI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB6891.jpnprd01.prod.outlook.com (2603:1096:604:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:17:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 12:17:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sPGIaAgAAWuBA=
Date:   Sat, 12 Jun 2021 12:17:48 +0000
Message-ID: <OS0PR01MB5922350291F1EB3B64661B1F86339@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <1623434133.974776.1208942.nullmailer@robh.at.kernel.org>
In-Reply-To: <1623434133.974776.1208942.nullmailer@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [86.139.26.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a7c50f-35ee-4f1c-ab57-08d92d9c17eb
x-ms-traffictypediagnostic: OSZPR01MB6891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB689165847A4EFD4FEC0F2E0486339@OSZPR01MB6891.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfXKr/UGKEZOoapeI02jLGJKxo7HeQX60wUcrcPfLA1n77fQUsVkRb/7MKwGtRPe27BWFCdLK8YYU4cK+wfXbaiMbhX8doihbZu4TuysKFtOm2tiJC+b7mcHwyZJYXmYtTndBdM9rqEfLOayzTJOro4509AuL+qzxM5G3ZmPlIYpUj+ycwadutTP4d5PM3qA80jkUBvoEaMWmsH40tW3GVSw9JKbpDePNLdqQ6JXKm2d4VINJo281OfpQ2jZ9G4Cu3db44voIZxxsODm7U3P7Aje4ScAHh9POqlHoErLAynxv9vQPlQLLDdYRopuMgvg1JKr2cTxEhNbEmScbAeNgEndIjIERnKu5oiOkUJaDQLi3ze4gZngSZCRwbGmdnvA6lLEUCBGLJaOeNJBNT+8zgSffi69qdqNLGG5SjFCp7ZNd5pCobr1fungY3igV2KtsMEOO1bMMIWi9V/XNe5gzTSyxMZ+X6U652PKrUZWNubDYjJUVausScnBY9+NT26uvBqZUrufMgIuvY1FUgmmr6EN5pTtTr4khh1BlrLBbAOy01IzaMq7HzMigxmUi+jD6Jvk54p0SyfbMnJZbitlhDKdR8d7UwI1xb87FUitPexayF/TAjD1O5X3T3ZGHKqwFyBovtq2I30FnLCzqRh3WfcgbM0xH5TsEU0pF5O3CKqJI8g1sDGgY9+B4PhpQsiGQZW4UJ1CNp2wO2Sr15KtPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39830400003)(376002)(9686003)(8676002)(54906003)(186003)(8936002)(71200400001)(83380400001)(26005)(966005)(7696005)(52536014)(66556008)(66476007)(33656002)(316002)(45080400002)(478600001)(38100700002)(122000001)(55016002)(86362001)(66446008)(64756008)(66946007)(4326008)(2906002)(6916009)(6506007)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W7xADwnQP8Bxj/hPcAdZMBIfAVVp3GnImAArIdDMcKSbXxsIlTizfMbda389?=
 =?us-ascii?Q?esw5JbGyLIabFIzSg8NdN/K3cMESEu7CHbSadNwLwngE8xe6zt9WWFETNKKv?=
 =?us-ascii?Q?2YPPFY+gpxp6CYoqXunqofG+hEPUvu7FAXg8spvZoO6B/+2mfmXSM77Hq2aF?=
 =?us-ascii?Q?j+R0VxTSRZFcnNpOX9Lb0FHcIru5QTo8LHfu5uFuxiTwPPTvBpvFj0CFq3EK?=
 =?us-ascii?Q?/AkN/96DkPU29qtz8E86ZpiSdM8GpRRK0V23d2O4FTUKo/RS9xc7Eras93qc?=
 =?us-ascii?Q?zvAI4yxx4A1E44zq/kwQMrz9WEUir7Dxrh1SXkmZccIwsOB9SEHQH4yhy+CS?=
 =?us-ascii?Q?RahtwFhTB1A4hI7Q4qoqkVvwZbmscYjCN0aBp8fY1tKr4dndz+3KhNh6HiMm?=
 =?us-ascii?Q?XbBuGp34JoDwBhqH5jSVtG1HO7BSaGSP4vdGr9QYB0J6Wb+s6UYkg4nx+2wl?=
 =?us-ascii?Q?5td1TRzCmudXjZNZV2HJrqbULGZy45DE90aLM8YFCGKzj84boQmSj5dvakRi?=
 =?us-ascii?Q?GJ4shTmG7jLCSLtnRhhDYCtQPVMsDTzIpUNYF5NkHe/ZDra/1oajaZo7kBvE?=
 =?us-ascii?Q?lZ517QijJI4XGsMkS1TMMnd//gGHlIlf6ImIc4kvqZHJmqGFcB51L5M1de6+?=
 =?us-ascii?Q?B3FoyifDANAcV4hL7JvFcyqDibEKYvuCQ/c8Lm71yzLx70kXU3m8Pabk8XIw?=
 =?us-ascii?Q?gv+k0nl2tRhsmveT2xePYwXojQ87WHI05EWCqkYmyR1qE6gjIjT/BYm7KVbq?=
 =?us-ascii?Q?IKSDGt6uxegppEofHk6Xnw7ArXZ6UkPX0PkpQa7i4p1jJO5UeurYknWMyBqd?=
 =?us-ascii?Q?3HHPFed6+BFQq6O86ManasGa8KCkgo50sWbcBFcqjc/kRU2UZt7x/9KmaI45?=
 =?us-ascii?Q?UXTYybWLbWxdlU8yh8NkA7QxBwQ6/898qcmdpqwKUHg/tHQpVhVquhJD1PHf?=
 =?us-ascii?Q?NOOBmPU1xuGtOKEkKBY4+Myrwn+R7fCnInPZSI6EVaisDn+PJRfzwBjr4fAF?=
 =?us-ascii?Q?XAN3CPDJ6BMk1j/w8jbVoOQOHiaXLDcMqKqypMbQd0h4PfnABX40Sh4D0cmZ?=
 =?us-ascii?Q?bRMcryolpeR/RJadoAr/5qLv7Krmr1jN26v6UWmOezFvF2HcuCnRDiI2SyQ5?=
 =?us-ascii?Q?lRwDPSuC4AO+tI6o0VQCfkSke8dcnjo88vGAPjAUc2Pc731tN9ouS3UD7StZ?=
 =?us-ascii?Q?1XdMrHwNQp2zSwh+2ag7Vf8beY8TyFP5nQrxZGH3HOGr4SydUqVoVmGnO6Ln?=
 =?us-ascii?Q?9PO8o9A9kQvQMcCBLuwyHA+jIeQr63RO1ttalnVpcnXkWOVpf5VfrZgMiD9Q?=
 =?us-ascii?Q?1Ak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a7c50f-35ee-4f1c-ab57-08d92d9c17eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 12:17:48.6097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oEHYwK9Fh/ysf1gpuzAemf6dIGH1VYxQDTQ7UwkNNGmY5c6w4C/qIz/vgLQnKTOUpVm6KbKszCK+fmn9M+BIYtzr6Q6AxgrGtzGWlbGH+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6891
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hi Rob,

Thanks for the review.

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> On Fri, 11 Jun 2021 12:36:38 +0100, Biju Das wrote:
> > Document RZ/G2L DMAC bindings.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../bindings/dma/renesas,rz-dmac.yaml         | 132 ++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dts:20:18:
> fatal error: dt-bindings/clock/r9a07g044-cpg.h: No such file or directory
>    20 |         #include <dt-bindings/clock/r9a07g044-cpg.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:380:
> Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dt.yaml]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1416: dt_binding_check] Error 2 \ndoc reference error=
s
> (make refcheckdocs):
>=20
> See
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wor
> k.ozlabs.org%2Fpatch%2F1490917&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.rene=
sas
> .com%7C0b0cf26acc004dba607508d92d0222fe%7C53d82571da1947e49cb4625a166a4a2=
a
> %7C0%7C0%7C637590309476730777%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
i
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DlZ%2F0v=
9D4
> 9djAW8E4sA3zcHOFs4x%2F073f40FkAGZJ0ZI%3D&amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.

Sorry, The dependency patch is just queued. Next time, I will make sure
dependency patch is in the most recent rc1 before posting.

>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Sure will check and re-submit.

Regards,
Biju

