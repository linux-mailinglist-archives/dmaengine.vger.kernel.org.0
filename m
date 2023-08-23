Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9FA785EC6
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjHWRjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjHWRjE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 13:39:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E29E7A;
        Wed, 23 Aug 2023 10:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0UGGGJfOFZSgBJ0A6JP6vo4JYef5pvezsbB/wSRdkhJJf5pwCYwVbW/869t5qKHd2BXn70KVkoJpzR54vLFD8LXxtkK5alJtjp0tRRJWd9q8Bb8akRz3Y0R8q0HfKS9NW6SZemoRJp38JSC3TfnB+3/mdItbmDRC7PiZaH6EG4t0f6t7xZ+dyH6MbNuXt+hfyL7zKfKPyqoQvGN2KdpLhtAJALRMEdEaKXTqr/X++nxcJ/FA/NWOxcFSYlKoAHJbKYXgjTSTsnpBderrvl8smV5ygsE9ZHSyUTLB7J7IOKEAtyS+Fpw6uvFfRp7RIeULg3iwE1Jkrzu2l+iKPW23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMUYwsRtBAh/+0iZK2Sf85WA3fF1W6BKSS5ME/EEtO8=;
 b=HUf4v/Ow3d8woetJ4avhy7X4LNgH/E9plps3+lKCkkuAr9x24Q/ZD3AcSD1e0jgq4+4FaMeOCC1rNUQ80jG/KQF+BC3hhyYN7z8teo9IFsm6nJFQLwr83w4TE7FtwzGgbRSzPGVn1f00oFGZHAw3cJbe55y38l1Mje2rw8bQTFS5fWyqRGhCzOQlSRjtv292sAe/LKUgF3LmcigQKL/uSe/Z9b3QiHFFubA1ctgndSjCjfUWwgHPPZseNtLFOdeqhiVDXvDydVcM4mAvq8mqvwBu+9Sch3GwPxDryanSYjAUsrXETjhcWtxDI3H69OGCue6kt/MyruZuIZoNzzNdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMUYwsRtBAh/+0iZK2Sf85WA3fF1W6BKSS5ME/EEtO8=;
 b=EkvFcUx6ZBtZDL3jvTO1Aol5M71NOutELuxLF/YfO14zMdRmOcJtCCHALQQEnpyNKL8kpmb5DvsF4NzIqteFyMODFI+yFEHLDQiOqj3kcJIzwBH0ocy7gL7m/N0J6XqIzEpxljOIM/4+Hnb6HIJHmsNVQtJ+GmvQCKEvhYe8DLY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 17:38:58 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 17:38:58 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Thread-Topic: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHZyPOqeZCnkJC6tUWnKK5vO3ejB6/hAxuAgAXJTuCAAyoHgIAORx2A
Date:   Wed, 23 Aug 2023 17:38:58 +0000
Message-ID: <MN0PR12MB5953AC3094F6BC7190266104B71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
        <20230808154853.0fafa7fc@kernel.org>
        <MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20230814082953.747791ff@kernel.org>
In-Reply-To: <20230814082953.747791ff@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: e4b1895f-1842-4e72-460a-08dba3ffd4fa
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LAaTaw6/Ly1Gw6SdnJ7QtxtcmEdH2oxU7C/0TBr/I624FZKOJA5kcltCIMDjEY1hYnNEC2O3Tg9/IsRuWMyCeIMew0JZxBLDx9o3TQmDke/i4iOBWyKiR0miReVtzeZa/kwAtrgqyrZqq+GaUbdKqI+w2UCgfqP3iYbjMj9hmBfKcHO5t9Uc6wEsAYlzb9ljYOXubP9XbjMBBZ/J0oKPyN2L/5caVt6uTtrXUWW0RdE2J7zlMoRlKW6bhIinVpJUUlZ9Z+lNhTfGzB9vUv+E/96l6a8t6qs7wIynMJTiOl/aB34xOAL8/JzRyYHJ8/1LzKZQ++/z3+nfTeIo8srDzJ0tAJlZEuJWN3/T0RNGgC4AoYeVaaEha46qRiKsrJln+e3+VdWBlIim7R8CcCINk4y+y+eYP9x6Esq9VyF5LsEiY6RTeSoNACm+bKrlb1N6w1musAP39k4mksXKS1YwS1/RON0VTsxOKHCdeDZwwABfVixoxp5w2PmUbcMtnuXq9h1nvEZIju/xihkDwyP+E09L5tXxWr/JhQPGrbbqCJdBlHH7LsGTstI0ImaMEJXCV7MmusnYIOYL4GVaJJUSiEPDgVZN0VuqI6nsXBk7Bg0WtnbZ7D6c+EfOPtEZCU8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(83380400001)(7416002)(6506007)(53546011)(7696005)(38100700002)(5660300002)(52536014)(33656002)(38070700005)(86362001)(8676002)(8936002)(4326008)(9686003)(316002)(66476007)(64756008)(66899024)(66556008)(66446008)(54906003)(66946007)(76116006)(6916009)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jq1TKxvpZ5S6IkEVXP0+dngCQYMcdibnoj5aly/1TVuIi/YV5OMeuUpqBMYp?=
 =?us-ascii?Q?q1RRNK5oqU/Njr0Dr7Rr5oxU+RWqxMdYwl06M66akbjgWkeUHXwFbQEtUC2E?=
 =?us-ascii?Q?m1YrxDgXxaSJxa2dt2dbTZe0PaKcmgXGCCMFXNGvAcsXYJH8Uwx8TlEKbfi9?=
 =?us-ascii?Q?9zv+HNd3BHc89r5neJ8vj1YFjPZe8G+ssZIyAbHvt4XYO1rncI300iVJ7+2U?=
 =?us-ascii?Q?kzVKS9YRXWlTlNaURFpNHm8NQULJuYspRf99VnKJzi0W22cR4vTdxUaGQZNp?=
 =?us-ascii?Q?2zYH7EWEhh1gkJ9qBWNz9xuvGxkMLHWyOuKBxuTrW5fXhFbNzR2Rv2joVD/V?=
 =?us-ascii?Q?V89I+zMfKW/g6Qnq5YHnjN1dpK6Tj/Wb/eee5iuyu3Zivitggu4h5G2XYja6?=
 =?us-ascii?Q?p13XnpyawxXHVQJJu/W6g5wUU/oVRtOncGvW+hUc5x7imbJNosmyMF4Adiv6?=
 =?us-ascii?Q?If7vqOErTnSPNuKe99VF6B7TOXtBvcL9u/SSL3RDPemhB1xLdZNDwAdQhaat?=
 =?us-ascii?Q?vWCBjJvm2r0ZXYyuapGsp1DaklcKKVxSnpcr02CUyI7wjOaA0tJC5/+hRdQC?=
 =?us-ascii?Q?b6fmRVvK6O/7AGAk9rJAyZWczQ0RDjqnrZO5XNUbUyxJ+kI0/osF1EVipukR?=
 =?us-ascii?Q?Q9afgJj/c5Ek+0VKlhjUL/5Vfpoew+Y8qtJrp9FwUQ9lEk8md1J3dJftkl8n?=
 =?us-ascii?Q?01W2qPBRBWKQ4m9ZZSo1D7PmZYVp8ro1VdUfbJ/Z8lviD2hFe+Bg08YubZOC?=
 =?us-ascii?Q?Lgs89E8Q6YN5WBVRY2xJ8mPw8/Cer0psWQLbfiCsPZU+a8hSyxW6ysDB5vQm?=
 =?us-ascii?Q?aeta77AQv8V57b4FHrHuAUmu5yuRm99fu37/riOd5NOKodW1GGixGrYhqBx1?=
 =?us-ascii?Q?1w9ooZ1EGJIA4dGiTz5EWnkc/QgJs4gA16xx+hWH+taKh+3lQPTYGf9mjN6U?=
 =?us-ascii?Q?/vkoyw8AYAXgkZbhbkf0VnEJnGZFvSX8oWc4eZGg+SpsOoMZoDq6DQCCUgSq?=
 =?us-ascii?Q?udz5AyyufasL7e/fdkou6UypQMTn/bqLAo5+X48TZm6Pcff59RuF0249BW/4?=
 =?us-ascii?Q?qGX2ow6uqOWpwFMd8ol7AcAp4pWag7fmJrD8VtHMS0sB5YPQb8rUpvuJ8ItT?=
 =?us-ascii?Q?Ie2khr3ShKyhdQYqrSXDVCG1rsPBYtzNUDadq+BGipSKMxYMnBjvtnSQ3YwM?=
 =?us-ascii?Q?9hg1xv8tvACqlfiawG/Fk13VWxGJ1r3t6pOOC3u/HRWIA8WV6nW3xEIZKfPD?=
 =?us-ascii?Q?048LgUPv2EFUw1Tw7ED+1zhdE2zZgX5bJ3Fc/4w6k8N6aP1enRLPJiT3F0pM?=
 =?us-ascii?Q?V7zBJgfiL907nH4BNdwDfyjivzMgKMoLqndnT787CPhtgUs/weeCgE19j47w?=
 =?us-ascii?Q?MfWFjEbhIqzTJJzW03No5WicgvPLz52ZtVuTxFAQI/EKXhj+UM8Uw6ARGsZt?=
 =?us-ascii?Q?Z+uo0SdsetCXZKgNIwBSFYHa+F8pPhD7ZPR9AcLOt9b39Hs+uPeWuIaFddIZ?=
 =?us-ascii?Q?5+jXn27JpQSu+SxHTpoWx0dt70aWLKI7654+8G/SQdevsu79qsSAJYseNGjR?=
 =?us-ascii?Q?q0+QpQn15zTft5U+iV5OiltfMM+FUKjZRBsMiC4aDCRSXRrxXR5mTa3bN+ol?=
 =?us-ascii?Q?0Fztu3xxkEHkLkSZ/XXnDL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b1895f-1842-4e72-460a-08dba3ffd4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 17:38:58.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MkJrXqbStNSJy/uqBBkP5+Qsf3lshWxbfydKGOq5qQeJ0LUheFz2hZ/h7JpPfC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, August 14, 2023 9:00 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: vkoul@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux@armlinux.org.uk; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
> support
>=20
> On Sat, 12 Aug 2023 15:27:19 +0000 Pandey, Radhey Shyam wrote:
> > > Drop on error, you're not stopping the queue correctly, just drop, re=
turn
> OK
> > > and avoid bugs.
> >
> > As I understand NETDEV_TX_OK returns means driver took care of packet.
> > So inline with non-dmaengine xmit (axienet_start_xmit_legacy) should
> > we stop the queue and return TX_BUSY?
>=20
> You should only return BUSY if there is no space. All other errors
> should lead to drops, and increment of tx_error. Otherwise problem
> with handling a single packet may stall the NIC forever.
> It is somewhat confusing that we return TX_OK in that case but it
> is what it is.
>=20
> > > Why create a cache ?
> > > Isn't it cleaner to create a fake ring buffer of sgl? Most packets wi=
ll not
> have
> > > MAX_SKB_FRAGS of memory. On a ring buffer you can use only as many
> sg
> > > entries as the packet requires. Also no need to alloc/free.
> >
> > The kmem_cache is used with intent to use slab cache interface and
> > make use of reusing objects in the kernel. slab cache maintains a
> > cache of objects. When we free an object, instead of
> > deallocating it, it give it back to the cache. Next time, if we
> > want to create a new object, slab cache gives us one object from the
> > slab cache.
> >
> > If we maintain custom circular buffer (struct circ_buf) ring buffer
> > we have to create two such ring buffers one for TX and other for RX.
> > For multichannel this will multiply to * no of queues. Also we have to
> > ensure proper occupancy checks and head/tail pointer updates.
> >
> > With kmem_cache pool we are offloading queue maintenance ops to
> > framework with a benefit of optimized alloc/dealloc. Let me know if it
> > looks functionally fine and can retain it for this baseline dmaengine
> > support version?
>=20
> The kmemcache is not the worst possible option but note that the
> objects you're allocating (with zeroing) are 512+ bytes. That's
> pretty large, when most packets will not have full 16 fragments.
> Ring buffer would allow to better match the allocation size to
> the packets. Not to mention that it can be done fully locklessly.

I modified the implementation to use a circular ring buffer for TX
and RX. It seems to be working in initial testing and now running=20
perf tests.

Just had one question on when to submit v6 ? Wait till dmaengine
patches([01/10-[07/10] is part of net-next? Or can I send it now also.

Thanks,
Radhey

