Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C84DB37C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Mar 2022 15:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiCPOmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Mar 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiCPOmH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Mar 2022 10:42:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2124.outbound.protection.outlook.com [40.107.114.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964DA5F25C;
        Wed, 16 Mar 2022 07:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArfGQwIewrckvz7ChC5Bvk50dWl49eLGI1YAXbgwUu5HFqNNmATECg5871en/AXu83nWF6+ZI7JYbTOyOdQACq5ayDpn5bd3oU3bckgB2E4bt/91042C0L+iKtFpHnxutx+lYBdlci/i5khDuL3HWiYDZLNZMwdxpV5CbKbAI1wBMzjXMjzdm9oRUL7OhmAXDdSYggYLtw/jwkGYTtNU23k8fQx/qvmxAd9K16JM1GI4dQUd0kn94VKvQwS36j5i9YlgSXWV+JEWFlSli7qAxL1PiW6Gekrtf3ptLoeTE4w+uQIqy4eaUWuFdHr2gK2JguRwbiskrYJ1NkuiQiKvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s54YZo9fc4LTVbeUxo4ZQ9ECJQo0oyvIugRx6f45ZBc=;
 b=W8IVW56tgHBnux8yBd5Sn+OF8BNpoElEqKwo8KyCbPyoc7OiEVEMcIVsKxOppyFatXq500mcTnTahfA/UI2u5lrRR2Aa8ISXBo3aHd6YyfabtfURMQJEVMLejdrWG16J8PncfCZyiOaLHBqXUYyktiRKM2rwhKy1Uw4nP3KrWjLKZkgcLsQDVFqGCzLOAuES4d3kO96bgqlfvfCYt2E2eHtPHTEofizfu80uVHwfWtKW4Vig6OlwEuwyNy0u+v/Vfw3yFJmtHbrtc0DLwLzFRkeUQB9kWlTPJY3Fnm5St4RYaKe/QTh7665JI8tAgxspBRfEVTfWibnwIdMY4oTtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s54YZo9fc4LTVbeUxo4ZQ9ECJQo0oyvIugRx6f45ZBc=;
 b=TBbq9wQJ/AKO+vk4xkTNI5zdh81yeSRijZ48mHPRTCBS7w7Un06SqyzMrf/1vXc04VmmyckzDNRXRMYfTxB5Ia5TLwnx8vuCKbCCreMSXSuCcBS8lpVWsU2mURdpC5yyVLko55D8Y0NzZ214u7bnFXaPJ0jGd7NmR9hB++IOu9U=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8613.jpnprd01.prod.outlook.com (2603:1096:400:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 14:40:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 14:40:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
 src/dst based on the transfer direction
Thread-Topic: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
 src/dst based on the transfer direction
Thread-Index: AQHYMldDdX1L0lQMuE6FBhAbZY8t16zCHncAgAAC6wCAAAFOgA==
Date:   Wed, 16 Mar 2022 14:40:50 +0000
Message-ID: <OS0PR01MB59228FD4EE4660D1468CC07286119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59220760F588124231136C8686119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220316143508.GG1841@kadam>
In-Reply-To: <20220316143508.GG1841@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a31ce8-8245-4baa-ad19-08da075af791
x-ms-traffictypediagnostic: TYCPR01MB8613:EE_
x-microsoft-antispam-prvs: <TYCPR01MB861347C9C005420999C3505086119@TYCPR01MB8613.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17R7qIDBgTu/tvJX/chN6kFJBV4IbbjkS8+mA1WpnZjIDPUI3M1QXenHq10g48IPlB/Y9bH2NFxoAehoKVH+oWrDclglXz+xMGa09xhMLmj+Hp0Cy/1vfZl+aZaz1YmFcD+pajEdCJ5oCkM1s/2jbMyfj3SA9LeJ+m2odmU8P8k/yI5ac6KIaa4oEe4nm4oqQLUa6kg1jsykMfZArAXMhO3OxoAGSzLA2O+Yz5isOkcLFYKeK9YSe0Lu4I5eYBOWxhs+vHylyH6LFOmgvyngtx+fp2v74JljKJlcQE7pIebvzkIiGiQfb3Swcsw1OwdrAn8aqp3cBL/9DmD04g528Ia0HX2/gbEwuNG1HUGF//dzW4HftvB8FLJQWE7FuoIGVR10CF2Y00Ltl3867SjqBCb+6aDDSTCgUTVSdhnypAzvxBOT372E1rQdYnV3pk5ZcICpA72sF7T4Yr3PmMPoHzxXLe7RvSN81hCY670BHmBSG89KX/GStg15iQ8KGE/k5MeIDblDL0k8p8IkCWQEXV51qtIY0nwkB7KX8b2TfhWX5ng28TlkIVZiEuVEE3JO4ElVqqo/JhOiQYHDHnzCQCGeyHanSXqNXT3jq09YXEBnqKuMnar/z8J7znwoTiLMcwT5XnKOilMoK4lHUQ2DO5dlDy2QRDTJKBUgKQYXzgXNIv2hRdvt4yTdsXc1pgW5UtDwplK+IkG4T6yuvDsN0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(26005)(64756008)(66556008)(66476007)(186003)(66446008)(66946007)(33656002)(6916009)(316002)(4326008)(4744005)(54906003)(38100700002)(76116006)(8936002)(122000001)(38070700005)(52536014)(86362001)(5660300002)(55016003)(2906002)(9686003)(6506007)(7696005)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IDkfu1o5W4z9Bpy28gCyLou68g6C/nL4fviztxnJs7FXYiOXJeRpNkiEFGsm?=
 =?us-ascii?Q?u/XezSmcDTJkmaxrMbJNLbJOPg+mdXTtyv6qgVV2LPpUWcFjsTdJSRjnLlCw?=
 =?us-ascii?Q?dEV1z1lOnd5tKsVcMfNZJXyyDdpBAKNqdbtByrwMFiCZMSjQk2z622LB/cTt?=
 =?us-ascii?Q?UQWPa7WMAVYu73qhIqTKKcn96If6Exegs5vJfW3euf9kVRzFbVcrv/uOtc8i?=
 =?us-ascii?Q?VMhw+0tqK4KYAA5jn9P63KFkWIRtK09Ql/zQm54l9qJEuasXGbFBVt+GJKzV?=
 =?us-ascii?Q?geTLatgHAvv3gFpS7zl3Qkll88hSCF0VEP8efEEJsqAsuQSnya5/f4/nj21d?=
 =?us-ascii?Q?cyMUpM/RkIeZhXQLV/WFxZpScUSH14fsZwgeHqHawqUN2pmgwJlT1Bn4sLS5?=
 =?us-ascii?Q?Jfzc5coNGUHasfp3P/YpbLPXXvDH9ovoRFr60EH1mERCRlYNoaup+CmmzHMt?=
 =?us-ascii?Q?8qQ5NubjuVb+uv/dZbsueqxAGxAGttgOgIBUIY2LSFNqBDExoZC5nnonMnjG?=
 =?us-ascii?Q?x3oT468QvX9HADZ7khq5b5F9WulEhr2um6NOiIX1uv3peMqwllzKoJbOWZbk?=
 =?us-ascii?Q?kblCHzvqgP7EMNja1FAkpqtAsPTl8waK1ifE5xIK2zlZhl+TTDMkMPSzQbVX?=
 =?us-ascii?Q?UV6yoimGE4SOWvHM9m1X+P/uvDf0AFYGc1lJhqq/ophOlctEP268yUg9SNtW?=
 =?us-ascii?Q?unH+wtPsPDAJ0VaXwcDW5K4kvdIvFqSZQYS1sRDyiyxdLh0dkucfoUxSGMH4?=
 =?us-ascii?Q?PuLtZedFViqln5JrpHIKZ9q458xY7u/NZFH/Upa0zMNdTZqZd6UEz7sGchPZ?=
 =?us-ascii?Q?T7j4ZR8hSC7KSNy6mtoXmMLyOzSR8oqKbdKFl4xP8LcA98HUw1mws26GMfQD?=
 =?us-ascii?Q?BCzsroAYfv8dzCNBJMpeosb3+WRF3K0eDzZpM5p9YOjgz29bk5/tFTIMWg74?=
 =?us-ascii?Q?2oRnjMOyXFYB83Xd0l/+dkJ/7dC2Vwnmfc1bVgL5+i5UUAYD1o8I7ZRT0VeX?=
 =?us-ascii?Q?gsNn9sc76Pj5C1UFCSt+1/0F8SEpbTETDujoX/OZ8BpQap3Q51Vxacv04MgG?=
 =?us-ascii?Q?icYMDM7f/kolLsnydFseCXgcZT3AWlQnhsawgkWKT/9LWkQz9dHbzehy915b?=
 =?us-ascii?Q?txEOoiJ1oq3xt5VA3QWcjq+GA1sYnJk+zCGuSua4tzVSPWjZ4cS7kEWuZw1Z?=
 =?us-ascii?Q?YsY+GlM7tQ5RmHb2Jh7ihXVxBn4SYHdcRcKPCvY+RkK25UE39oSU5bytVnkH?=
 =?us-ascii?Q?nLGIrMOBCd7qVpqxAvna45QdKvwl6koGwJE4ojdD5q9M0o/+hFxUHlEV9BhF?=
 =?us-ascii?Q?9IS/sqrCFzbBxz1cdCRK0D/UXej4iT19fbdzTPy6RH+2FbBjeTGOBPQ1M2LM?=
 =?us-ascii?Q?yXiuGjXGAmlx6t/r/Aua8eJwDXMRVDfPkM54T6z3Mgmut2UfBu/b6FUL6Osw?=
 =?us-ascii?Q?7pPdwl74X6uxK4CIlQzhsrLlB2wsPkZEhVfGZubz8QUtGInioZ+hIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a31ce8-8245-4baa-ad19-08da075af791
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:40:50.7379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmznpF8QxUQkgy6BnIJO0aTh0bsqqHHHqwQk7CPIpMyb+gHVMdXz+AkYdff80yTdZbI8mFEzsBKnx/+bjvDEqdzh2kQDHtMzRrVUTAL3VtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8613
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dan Carpenter,

> Subject: Re: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size fo=
r
> src/dst based on the transfer direction
>=20
> On Wed, Mar 16, 2022 at 02:27:01PM +0000, Biju Das wrote:
> > Hi Vinod,
> >
> > Gentle ping. Are you happy with this patch?
>=20
> It's only been a week.  Please wait at least two weeks before asking abou=
t
> a patch.

Thanks. Will take care next time.

Cheers,
Biju
