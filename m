Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0292567E04
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGFFvY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFFvW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:51:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36422287;
        Tue,  5 Jul 2022 22:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giDBg6ExWLsFux0Ao14HjXXDltJGhfsEGdRMW12ewkrYDshaS9rqKukc6c+qK9wUYealUp0vi2QXnnZCqCKsMitOJQyIah2BJenKj6XbAVEYZIweV6Oo/JnxMMDkapSGleqd3WId78j7mA0YBxvUzSWs2pkgItkCSxXScimGJPR8b4XsSrsICPWlX1E6+ullGoBSeu/nRsEueXkG0Gi78xgQR3Xw+PoX7ypg2zugSG92hzvZ3FgBZHl5EXRAFTQZvX2oH+ET7Ev46xAWRAnFp/esQQAYVblQwybzZZ+UWxWOOWZhCpUqL7vctq/7PP3Qrd2hew+Cucy7JgnVhwBMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAZbX+jexagy0SM/k2K+24QhV+7AtzHFiaWSBseadM8=;
 b=UKEjPFtg6ggV23WcNF230qRO6aIg+Kk5880XT4xQAKDM6PxYh0lZNgUodsFWlKq8Pi3JZP+OaDZL8nC7JxwsaUEinAwO2psB6F/OHfDJSLS83utFLG4+tFidGuWFEhCp2xlU0InD2/Hl81m0NahKeaLkls9nr5QHfbnrBvnznpklSL/Md0wTKe4T/NDF2nWROoDoqb3QYGaTrXNMbhY068iSEMlNnS7Qwk3BYWnY9zB5uSsLKRHKHmJqNYtDcJZDPrigJ5Wqw5RbY0qV5uAM8CBgdzC8ACLMhtZh8f8VKC5ClRNfj1pyg6IRpMFMa3NwZv3NCmC1LyqUtIu9KUT4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAZbX+jexagy0SM/k2K+24QhV+7AtzHFiaWSBseadM8=;
 b=ESDCLBeMR18DhzDp39vwPIyWZoqaVvINgWdpXUMDNuIoPnPsqEFDOgVGzW0nfr/DqK185uVYYtLWmhyWn2VavFx4TLFl/xiKf2Xlor1u8WB6HZTDL15lcsODvxDXg1F636hTQ+JmG53bpwVRL5teoOjU3oWxqghw7hIYtuqe+WA=
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 05:51:18 +0000
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::81e8:14b3:6b82:a027]) by PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::81e8:14b3:6b82:a027%2]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 05:51:18 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix compile warning 'Function
 parameter not described'
Thread-Topic: [PATCH] dmaengine: imx-sdma: Fix compile warning 'Function
 parameter not described'
Thread-Index: AdiQ/GfzadBrtjBZQdOQwU8pe0FBTw==
Date:   Wed, 6 Jul 2022 05:51:18 +0000
Message-ID: <PAXPR04MB90898349568E2DC555036951E3809@PAXPR04MB9089.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bab707d-7fd1-438b-5448-08da5f138bff
x-ms-traffictypediagnostic: PAXPR04MB8349:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GyCHUH1KMNNOkQ5hdzccvTWUh5zMEm0HPionHO8mBrcvzOPuzMuMC9h4Pulme5NGuyW3WL1vLFWq8mUz7CY8i7bvp2/a9fhB/yBZNFDvD/PfWcAiQv/awXaF2rJ0HWayZBlAR0Nz/O0wa0r/rwi+4G9Z4QUbdZJTdq4XtqXY69GWsjfoujsZjT5AyUm0fIvL38HcIaeFgJH3R92FoYOb+QV2UUxMzEcIH8ZZvdVDY3q31z3wQ/h1reARd7Yq1PzlQAstS3bS+omWotf+yjreeEVWgBN4JdZRpaKIVzKQ5t/Z5PngrlcpWIedaHgV0OTPfd5jxyRxiIEgJ0gAxWccg/+JDL0gYcf7w79yuecFCRVfECt17o7a/XfC2cFhz5mUztwl0hFbKOIZPt+4X0DLk44HqDN66MPL/CHPyScTYkocA+OQgi9pBvcne5Vz5GR1+/4+oKyPLTBmCTlAM9hcl3DV6iFAUAxg5oe9Gm/uhp83cuhjk2TxnvPEE9b75H8RDE5O6jmEhEkOl8jJ7ZP4b5d3ie9eK4MZR8FHwdE9QIgF66Ns5vYydMGTbwMhx5U4VZesKjbuoE4dx5UgjvaHAmK4h9Tr41vfCSb2b6Ty0EdopjLLYXmqIHBoTHbQhzK1EHSNRLJ16HFH4bkIaq2+YF2ZjByQelZ7DqbNfxKs5rebuorvgIg08Oi+GCYtBF3rMJZnA8xNmS6Qbk3DdeZg3QWc4b6OigC+hsqWowJNj1IvDCHJxMiBMNWWoDNAFa3HVOwrzUvJYXm/j5bo3K2j0+60ZY5JgwITrJ8Xjzdonu5E8lLr7cEPLNltIj6XWo5E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66556008)(66446008)(64756008)(76116006)(66946007)(4326008)(33656002)(8676002)(4744005)(71200400001)(52536014)(66476007)(8936002)(83380400001)(55016003)(86362001)(5660300002)(41300700001)(26005)(9686003)(7696005)(186003)(38070700005)(478600001)(122000001)(6506007)(38100700002)(316002)(54906003)(6916009)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XUcAVbn25m+tQ5H+IAk6TvD3HLf93zJ6ul6iP8ZZO3wRRW8ekyqFCvGDtJaM?=
 =?us-ascii?Q?JgP7ics+8PQRmEUg11SAc9Uyq3+qc4AWczl8rSW1uCQVolXF1y7/rD6STR8c?=
 =?us-ascii?Q?Lr1tsZUWw35iRiUtkLPUq0xWa7cRn/ujjSkGP2X3GsEh0KnPHXftlAoCogxF?=
 =?us-ascii?Q?WbWRD9GhJOzWmwY/xtETwHAPsZV8nVYrBhdeRsgCh1SQ5vEZWxX0h9afD7uI?=
 =?us-ascii?Q?vdLWtQvDea+kPjrRYJaQCPW08uVArQuPfA6z0chgs9VJP82nXZO1GHJQ+8QU?=
 =?us-ascii?Q?jtk1xCZ7ayzenfJj5XLgTnzs0e3PQRlS1+bZZxzH1YBXtRVv1Q5h2JPR9q72?=
 =?us-ascii?Q?6Gjh1IHsLaIT6qXOdQxiwe/y2nEmrhmWnE9tYfBb8113d1mcr0pcjcx76bpb?=
 =?us-ascii?Q?i/wE1mPvi4cACf/4RHa20hGQz+T/UkvyqXsn5X6kYXlXHj0SYVAfim6hQ4Zd?=
 =?us-ascii?Q?ff4yb4GHBc8bYwtY7bn6m8VxXAAH6utCoSCVEm1A4VlxSW4uWXIOxrvp8938?=
 =?us-ascii?Q?4wdkl0Rgym+Kpu7budkmCLf5hE6kHMBNqGfa2F8WYO+P2E+e8TIjlslMX2Ka?=
 =?us-ascii?Q?3fihs3k2LGHFfy+BbAXIUViP4ACmsYg1PsWUTChSAZKFSTlnmTwHqRdSDS4m?=
 =?us-ascii?Q?0gONNnmmC8Fxe28D2QvITuqyULOxmgWSB12EqlzwYsB57VmN1fnxycbbkIa+?=
 =?us-ascii?Q?RMj/GbT69jKwCiHw1mMhj0ND2YVpVLXIK/Bw+C2UEiSwBgLHSGCoW0VdTX9G?=
 =?us-ascii?Q?GWwdw/1C8YQiNHJTrY1ai1SqTmNwBjQLpyERvcrtKnnRH+FUR2BHyFCCnrrx?=
 =?us-ascii?Q?jKZAuKDgit5krF2hVesqjgXAzsxNEzmdy0Uxm5TLjYL/c1xKaHZJKEzXv0iC?=
 =?us-ascii?Q?oZw1aYhrDi24fOPx2FyfOQU28JhtsVBVtKuxm9cutKuuL7rPNlvDi+vgLOl5?=
 =?us-ascii?Q?Gs2chtj3Rf3pjV8kmHoMtWN1s+lr+GN75yr5Ep260oFEk01924vZcts+BPOG?=
 =?us-ascii?Q?HkMhwC9eZu/T+mNv19280lOfrzHz3mJmlgJJ7XCRdJGqZrFQ1zAe6/4MseJQ?=
 =?us-ascii?Q?qXDavEFYd9Leh/trL/aP/64zDPRz63WFnWyFz2eiSR+Nw7s6SkBGPamUZoRe?=
 =?us-ascii?Q?IvXY/I2idHZVKTqpDXFujmTe7IOMA94hD3d1BvTNFyWWkBTPvreytIDlgnUK?=
 =?us-ascii?Q?MWot9qm5JaeCU98bndjIA7lCVt/i0YqceDkRe+wNpg/ePfS9kW8R/l37+zCK?=
 =?us-ascii?Q?o+H3VHL7mISd2wescs75mdcZYZDDB5DSao2WEnVTLXRA7Il4lHhAIQLPDQgU?=
 =?us-ascii?Q?3xGMvNfHEOe0bPAzBOlWRBzHud7tyBpwV4GowkiZCURBZMnyBeTkx6Fv5gGA?=
 =?us-ascii?Q?hfuoshRrhf8azNnNAQ0fpp4itnYACYpIcfAEYY4j6Vg5UhaAA0AevL25NKrD?=
 =?us-ascii?Q?qSIJJ9cco032JWkp4Wx35vggAKabQqs7dhEckV009GoeutuqWC0Um/rieQZV?=
 =?us-ascii?Q?PY6PSHDqQuNMryxP6lVCKe318eKUXUBvn3irQ8GyfojfAmnkefoLW2EXN64u?=
 =?us-ascii?Q?PSvlUAm8PsW8zpM7B7rSmR0OdA0Igf2QU4ZE6odb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bab707d-7fd1-438b-5448-08da5f138bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 05:51:18.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PSCSV44LOl3AtcKQ33nhDiXMO7B0pRS4Uzp9PtmzyDhUwlfkdWAts8QaEYALwMVgWEcrKQBY3jnHP/av6hF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>=20
> On 18-05-22, 15:21, Shengjiu Wang wrote:
> > Fix compile warning that 'Function parameter or member not described'
> > with 'W=3D1' option:
> >
> > There is no description for struct sdma_script_start_addrs, so use /*
> > instead of /**
> >
> > Add missed description for struct sdma_desc
>=20
> Patch title should describe the change, so add struct documentation etc
> would be apt. Pls revise
>=20
Ok,  will update it v2.

Best regards
Wang Shengjiu
