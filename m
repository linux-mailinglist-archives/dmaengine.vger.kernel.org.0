Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE54F579468
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jul 2022 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiGSHlv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jul 2022 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiGSHlr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Jul 2022 03:41:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F819C30;
        Tue, 19 Jul 2022 00:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBz++goaVTZsGsUeGh8w0QOosuv8BNgX1fzkwt+Uy2PTAm0MvjJkwu9T3UY3fVh65ZuubbgZcxoMDN9QjkPllsbSwyEt+qSKRXsbfYN/PPz1ai9A+IaeDbKdnInIrqadTtS/NUHnhtZaO1hFlCLp38CM5Na8sWJrmckTnfvVBJBA58N7V7UbOrTE09Y79eiCJKw7+HXMd63atczz6I4JklNfxBkK6MsGgNGVna9auLxzGIxDCXQnlbNtJxp2fB5A3jZilR6kgmYCjT3bCs3pnU25T0zYHS6xrNiwI6wYbG0tA/ABM7ekZsPMnVGmegvJ5YQGiADSi/DSWWI9fUDS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuZrSyAIHXgD6fPTQ/hd+mJxfmof1ZW3wCToq1txlfc=;
 b=H3E3mz2qWlDXvpQ0d7xJKuGIOypBfglh9NlK+jsUqeXrE7woqA2OExFife6AxUtu/xENajmdcDKBctGUOmkngdNeUvbnwf0VFXxq32PPtxKU8TUW5J+3ZWQ3N2XZwzQdlPKmugef4cwk6qAuvyq1tPuYxQSGUjyE8i7tno9cecKGG5LgcQDQSmOf2mhcG5DUblrbpcQoCzmO6UftpjyCmUOkXUZf3T0DMj9kPRyuzsgabmk4PJp7ZUi0KKu1i44sPLDP07iRQVscnuBzAfx/j7CZWLai2L6zHh4t4fNlZu+4AYJ4KYcYahFGcn4Nsr1UmscGjilyg5YxvPhr5e9ByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuZrSyAIHXgD6fPTQ/hd+mJxfmof1ZW3wCToq1txlfc=;
 b=It9/l/1NcTNnpEicodmf1p/6lyq9MnfYSH9EyWFKhI/smr/FirM0h43skf19+5SwS1sd+mJ4Ji9KP/nlozhptLfwZY/rkNyzRyvo49Ltr4jc/B+rKlNJxInmEDV0nu7zLYT7Y9HR6irCF6DcsvWP0wWDozvR/mRvmfm0m9765tnSOOTqm8fpdp4RaRqH35ajCjjV4GEXN7OgYMHYBfPClh7oE9Wz77Srs+zEioWQeGxXArHeLqbwNEG0AjlQaXIoHuFhFNzI2oQMwY+/gOHRA6v7W0moE5NgKPqRApcOtMGO1OeaQGtR9sPKUnLLjquCkZshuUcsYKpfcalavpImwQ==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:41:43 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2970:10e4:ca12:d4bd]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2970:10e4:ca12:d4bd%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:41:43 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Thread-Topic: [PATCH v3 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Thread-Index: AQHYlT1na+78Q7Y5EEKYW/nlrw2EZq2Ei0aAgADGxnA=
Date:   Tue, 19 Jul 2022 07:41:43 +0000
Message-ID: <SJ1PR12MB63391677B9E3249F98D8F1ABC08F9@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
 <20220711154536.41736-2-akhilrajeev@nvidia.com>
 <20220718191627.GA3375779-robh@kernel.org>
In-Reply-To: <20220718191627.GA3375779-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8c4ccc3-b7bd-41bf-9e44-08da695a2032
x-ms-traffictypediagnostic: PH7PR12MB5784:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fTxqu+bl58rd+2F+zQz4h/ijLkAS6uJ9mfLipF3P7de2gftC+Rfg2iclbxk5/cYQ0pCPTxlP5JjfCZsN7npORtRA3syI0I6C7IHXWKBp8OeJu3aKKqeMGOI8M0bXnlScdGkGYIIt0exXqY4XBN3H8Vvz0lGjMFj5cp89D7przV9ETJjFualxw8jNM4SvGzgui1ApohVEOFKjbAMX44jORqJH20rfgBL+cJrx7aM94wA6M92a0/8QvxtMqjEGCXcNMTiOUAbYAgl9ZYVHTK4iGzupll8Wj+ZpeMWkBJRonxB9Qsl/OdALFURlL3y4pr5IuI9lAIxe17lhmQG6qn7iVggAETEbCgop8IaEEgBNeRsvf7ydodAIjt49OR57Y5GtH30n3Yc8zW4oYxQ6E2CblhpR/xCO8Mi84Kb7X9tKYlotYdbbfBL8y56gobHVYBJlUftKdsktAI30m+ADha28AWxy76PxJ5NjjDGtl7rMGTJMxKRECPl5nKR+SIPo+s8bGfaVPPG7GmSc2bTuTMxi8pnjogjIwoHcY0V9/RTYkSoLZ3YZrF2IlkYxXXOj/nwzXchKsvSeGl6eS+aTkUDKMN5jyGRgG2nF22kfuIGNiqvZ6PkJcD0/5Uvr8bkaB9AjZEmxP+dggdmTN2yDz6dLqlPxV+3oPV8QhcoZEA2hd9yBHVAke/3N54OMs95+r0sQviLnmpz+FQqAP2uTLp3BRZH+Cjdqlh0zN9vguHklxDrfIwE+YLHvKH0xaphNoqDJVwU3CmgRWm+cSTeJGvx2R6ok76+4XnJcQ37yZlM8igLHyU+QLh2yCRs4BdhjRGam
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(76116006)(71200400001)(478600001)(38070700005)(186003)(316002)(26005)(7696005)(54906003)(55236004)(86362001)(6916009)(41300700001)(6506007)(66556008)(66476007)(4326008)(5660300002)(8936002)(9686003)(8676002)(66946007)(122000001)(2906002)(33656002)(38100700002)(64756008)(55016003)(52536014)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NN8N726Ycv81oJb2Vp0W1leyME0vL0l088AWOU2sycWY/DASLjvRcagKpyLq?=
 =?us-ascii?Q?J50uQFMzVPg4dhF8WIbbZfXrd64KEA7aweQiZNj/JooRx4tYBulYjmJiJmj+?=
 =?us-ascii?Q?YusBmbx7KLQuScvL/gIkGD96KL8DSJWur37FxIPsJx2r3SclivYkfc8+voVn?=
 =?us-ascii?Q?eKN6o3q2UWbzlSGN7tFMO7/4Q3P2U8GW7tgLCzGQkGNK9QDFcoi+kI8c1cG7?=
 =?us-ascii?Q?zDcXhQmvChsWgnM+bY7ZyNoDU5N8VjGYtOFHXEsQXMIDj4TG33xjHkc9is6R?=
 =?us-ascii?Q?R5Ofy6R+WmUdZ3T2CbFnDzUhWpkmdR3CMAs+fssODUo2058k97Zm2W+BpMTd?=
 =?us-ascii?Q?HGU7x/TpCJN7izAPyGms0zkkvc7Zg5SniwQjr8Q1D9TXFgfn6UJy5Z77XsJO?=
 =?us-ascii?Q?fwy/6QkMRi2261x0t4ITQsOvBCxtoLUiPXeDO6fVegAz0ErxkV5SjYSvP8Ob?=
 =?us-ascii?Q?9cIAtaBreO0n/COuUFl96hY3KPS/nd5JxFsNGR0Sf51UWvlb3rWYnbXxgT25?=
 =?us-ascii?Q?JGLz7s6AIn0Qnx4OpM13xgt5EGDQtgYPRZB2JyoaFNl1myCR/aMFt/MO/SPI?=
 =?us-ascii?Q?JyYwBObDSx6xwKT1EfxYmB5MLKyzUidKew+9U9vMcKBZKu79Jk4s78fIU0ha?=
 =?us-ascii?Q?T4Ja+S/UC//nsJB0xD5Z+za5HokMkwJsN9pIVHnFMHA81DPyn+YBtazaOZCe?=
 =?us-ascii?Q?gmEGmuuhlxaEwrEtPHx+AWMQJbWBrdSkUA3zeu21A+sBJxmybcuv4wGD9TQu?=
 =?us-ascii?Q?2eFgyrh1VMyE4VAGMlurBchzs50EyorMsRWgxsBf+jK9GYpu3Vjk/BhYU9EL?=
 =?us-ascii?Q?9RMbcirmY/cZk1givNoRzkvZ4nHvhP5PUPIJvdwqcTfkT93qjOar5eM37s+d?=
 =?us-ascii?Q?DFRrRCXVZ7h/Mc8LkwswslFAYRllaEQRUkIBvyZvSJr08LTzT5ECYI0dADn4?=
 =?us-ascii?Q?swWs1pfLdscJt1hEwxR26TTJ+AbCK03HSoKtPAh3PJc8mrhhB8ncQjsn2mkH?=
 =?us-ascii?Q?SdMYK6bzGotjcTORqPzWmVJjGazwa+4l2cAqIEq1TUQ+DKiVcqZgqH6fGk87?=
 =?us-ascii?Q?dkT+c46AdTKVUtGFcBRy29w634DoXtlnl6xo2HKXoiyKCMllGlBVIgD/npPl?=
 =?us-ascii?Q?hhb9AT0EfhP9cnHlj6GzuoKn3VAizhLpuVA2CDZKhsQFQAojuVhSxVzWEoQO?=
 =?us-ascii?Q?CT0nGdUhzSWYqAIVDErPI9rmu9UVVKToyfDMTW0gmDsxTPXkaDCPO73gZioq?=
 =?us-ascii?Q?CPUmf2HuScRA7jO4Oa2GzRdjOXuXujR7Blvduu92L7ziB+IFeb0bfI0G8i2I?=
 =?us-ascii?Q?FeJjd1pL9kGwBGGMfwizRnnK7rxUQ2fF0BbDvGpuDqGEEKDvY+7EZdWMf3Gb?=
 =?us-ascii?Q?wJtoZdQOJYcgY/8ZcSqndzMNce/YDuMWjNSk3Fi0MPQXS4DOC2If517BYRE4?=
 =?us-ascii?Q?/ht93e9t8QYfwgkjx75f/ynMfsxU3BxCi+3O/kRydHSMAO8Pp4i8nbI1kAGi?=
 =?us-ascii?Q?2j7VZ80SZBiixk0Z+igGBEIvNzwHEsB53+WghbTrq4ydgNyU55X1t2NkYMgh?=
 =?us-ascii?Q?AUIqVPSj1uPcmXsWkbXPL+4Zn6gAPdo/Rk1l/7jj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c4ccc3-b7bd-41bf-9e44-08da695a2032
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:41:43.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTnuqI1s6EkARs5lbl/e5eh5kQ3h/I7tMEG3dwBpE0YpfIkLgUNm1tGFBg4xG8IFrvGWerj2Pmo7zYzB1hnGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Mon, Jul 11, 2022 at 09:15:34PM +0530, Akhil R wrote:
> > Document the compatible string used by GPCDMA controller for Tegra234.
> >
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > ---
> >  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-
> dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-
> dma.yaml
> > index 9dd1476d1849..399edcd5cecf 100644
> > --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yam=
l
> > +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-
> dma.yaml
> > @@ -26,6 +26,10 @@ properties:
> >            - const: nvidia,tegra194-gpcdma
> >            - const: nvidia,tegra186-gpcdma
> >
> > +      - items:
> > +          - const: nvidia,tegra234-gpcdma
>=20
> This can be added to the above entry changing it from a const to enum.
>=20
So, it could look like this, correct?

  compatible:
    oneOf:
      - const: nvidia,tegra186-gpcdma
      - items:
          - enum:
              - nvidia,tegra234-gpcdma
              - nvidia,tegra194-gpcdma
          - const: nvidia,tegra186-gpcdma

Tried dt_binding_check and dtbs_check with this change and did not see any =
error.

Regards,
Akhil

--
nvpublic

