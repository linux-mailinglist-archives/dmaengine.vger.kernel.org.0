Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC98590720
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiHKTxd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Aug 2022 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHKTxc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Aug 2022 15:53:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12A6B14C
        for <dmaengine@vger.kernel.org>; Thu, 11 Aug 2022 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660247609; x=1691783609;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=gJiVlaWKfLyjSvRYtP1oOCguA7Nu29jOT4ZOZC0WStw=;
  b=gq1oNKVwfVYTr+7JYAeBk0xi8VmjRRI3GV6nI/AV/QcpOXvhIHTaZLR3
   sgR4ZVF/5qS4bHRwimleGG164V1NEG7/UC9ZWlI1FwvI90/jZtVdygW8b
   ZEpDigzQAL6jhRKggZmL2FU+kYobJr3mp4GFzuXVZKxV79/STy/T46kZc
   8vJhzyPuLltAdSlhJXsfE/0/I5tRKd7d2FJ/DFD6TtEfVodxLJ3Okfz27
   pB6NUEOUJufEBFg6Hibyyasz/LWJrQkSoqC4f6+Bl29HVKhqXu3fcKhnD
   iiuY8ko3wIWYC6I/RR4vdp6XJcI9fWaemRfTq2hj1bK4i/9UXsntqdFeo
   w==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="176056957"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2022 12:53:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 11 Aug 2022 12:53:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 11 Aug 2022 12:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlQKKDWFirnkRuxXkHg+ESIQT6YttWaoUQnbNxMYkcWALatnPq8fV3KvSVFhfeI9AUdHV3sJCTgeuyWOyPqm6xaNOWkKZp+zk/rJXjL5NXcGsBn1MoQOYbZCMfOC4Au9vYpMUzPsWlQUddaSAQ4+NRKfIR3YG05Luk+erE9bLp51/qxzoGN07LFy6efgBtUm95LgMFWnCN5jVtbBTla+kJ2cq5mrSr7ZmMzj/wVDKFjjN3YBl5r1aH1ZM8VdZu7xv8xvsl0pbNw37CkuLdiqOtWnphShUkTAKQUagXAKGuavV/ypV1g+GGHhCrcbNaABL8HnfClJ27J5om3wl7No9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJiVlaWKfLyjSvRYtP1oOCguA7Nu29jOT4ZOZC0WStw=;
 b=P25d+3RDRoPgYwdwkgEHNZ46tBUcpDS/gOl37ZP1xwunsfHu3aerSpMKuL5oKJmPEuPXt1R+yo9QQ7q/zhaA99CuDofm7mLoVdinTYsbYu4DEpBUvmxEYxagfPgvMjvsyJD8OVlczs4o6BVX/4RUZoSoA/sC4/QLOpbz2287XO47zIFCpQcd0vJkyjadQnCTuVTjWrb3UD8D+hMz+IM/JruMkj+BEWT8rfq4OfuQGjdDySGy1JaRUufZLbwnDkTKHXk8WYUNV891obowOLEpYqA2fQdGrQk79ZYB8LI/nPKnMLoCIZRYwGkXOzDAOoOfzaPUHReI9T7DmonLaJuqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJiVlaWKfLyjSvRYtP1oOCguA7Nu29jOT4ZOZC0WStw=;
 b=NQRqhO0thCAkLVhWb7zMWwiPeeykW8oUnKWdJllbm41vpsULEAK5//Ywaq/peAZN7wvbt7qwoKjvxuttzsThF+i/Bnp6edlLno/STbHCN1WLALWUtdUfEMqd3TPOpkiHannmJq9waYgN2v2Sqn+lxUeG994/ai97ooCcI7V1yMI=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 19:53:23 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5%6]) with mapi id 15.20.5504.020; Thu, 11 Aug 2022
 19:53:23 +0000
From:   <Don.Brace@microchip.com>
To:     <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>
Subject: Re: Question about using a DMA/XOR offload engine for md raid5/6.
Thread-Topic: Question about using a DMA/XOR offload engine for md raid5/6.
Thread-Index: AQHYrQqYtMqDezz+6ke/QF4DNuLhRK2o2CQAgAFEvyk=
Date:   Thu, 11 Aug 2022 19:53:23 +0000
Message-ID: <CY4PR11MB1238EE0B3F97F98619E6AB49E1649@CY4PR11MB1238.namprd11.prod.outlook.com>
References: <CY4PR11MB12385444DFDB1343F28A41B4E1659@CY4PR11MB1238.namprd11.prod.outlook.com>
 <725501fb-f559-2825-1533-4aca8177d87d@intel.com>
In-Reply-To: <725501fb-f559-2825-1533-4aca8177d87d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3f79a02-a75e-400b-9284-08da7bd32601
x-ms-traffictypediagnostic: DM4PR11MB5549:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umVjeYlnGlWg45eAQ9CXr+AAXF6B8UuwkzTsjG22OXst6r8VCq2t0BJJRzZkQwwQe0YlDHu0X/vvnHZ3Rd9jOKH4uxXuwkapdX8K9DcXkckK9g5U7wZ8/HURGFIKwSUbjwmkj2vdt33h/48m70hsF8WYjy8gi2pvVUchzD33oJSlVkLUzjQfW7vFM5KQdh3SeDXoYZKi1VChShEweXyfiatOW2xYSbheddOZcGzgFYss3NoaYFFrfoGVgAXITBQdxpMuvlQumpcnzMx1EgWQC5MqHvWrlDj9hBcVlRivJT+WV6oI7LG9YwvkN39wg1+8flv/UJ9lr1KuWcZVUhDGqcQv/bLshpmNMueNpNvk4nxUdHT6tXMoHLH0+h34WnUuuLa+1SkfVTGtXCo3HreCeH5H60rRDWmzVHRyXiJydxhJLXwfwtXtTo6HTV1xG7oiHnB8mtdpAUIAi9ynbBFvzVkMCVklr+ACy2v233UYM+oxRAyLqgrc5K+/RWytLs6O/HTxhluM8Ycm/HjF6e02qZpumndTFFPKhgAE4m8zGoEP639CLtp8+0VFXuwZvpodqJyu2/9/YS1YNy8Ks34iGX71oXKubVbuVPXrghlgz9DaEB3x0BPS8Y1lWOU6RHFe0Or/TVSybjvE7T4CisFgtv9bDsEw1EcUE1NS94bvdfIkUUOmSyUwprq260SeQ5+BD3IDvwrelxEYXk7hW0JFiurQfTPdQvecwbZzHTOepsXJC6zpHaLWFiaN+9mRvPCAZTZLGV2i6Yf5MOxtZyOlVaMrvmL61Y9V0wSzoIl3qgSqHeX7fS5kiru3cvsFrsRV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(966005)(71200400001)(478600001)(41300700001)(33656002)(86362001)(38100700002)(6506007)(7696005)(9686003)(110136005)(186003)(83380400001)(26005)(66946007)(316002)(76116006)(5660300002)(53546011)(66446008)(8676002)(64756008)(122000001)(66556008)(66476007)(91956017)(38070700005)(8936002)(52536014)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yauHUSzAWUl5OUpvA7zO+oZrLNXmLny19gzb7ChHdOVhOpJ8jt1CmkILN+?=
 =?iso-8859-1?Q?TBjPn0TNpavmQnJqFvxgfFcgJX1KOSRcxqc560ggbjH0aeasdpX00v/RQb?=
 =?iso-8859-1?Q?zxIvhI0kNWaF39SjbZhzElBvlmYUH8+F9ZUePYnt0Lj5ce21QUAxKipgSJ?=
 =?iso-8859-1?Q?MXXIX9Nyb6qR4Dwcpcd8NDhmFNc/z4Kmwyn52ILGpJyJIZlW/CmXaHYGSg?=
 =?iso-8859-1?Q?leR4RTBVbL1wNdepOGQNPzfJHMmIPnzLkQv8DiezuIiS1JNL2h2aZ49t/K?=
 =?iso-8859-1?Q?EbyqORVPnObAEqKUFmdKQzjEoIofA5NmXlmkyxRk3dTkc48cBvGqA8mBUj?=
 =?iso-8859-1?Q?vXY8h6R/b/+Qdf07BN91CZBc1V6Xqpj9+F+FqKpMYjVC0vRodyd7mb5qUH?=
 =?iso-8859-1?Q?FtodwE5YrVY9a0eLh/2fp8b1lsEfDhkR2atwiB/w5lk9IDqipbKnq0gUXW?=
 =?iso-8859-1?Q?UoEns1PB7VulvBAwJsFjcXD/lLyT13L49G9zcZJpiFMyagtX/21A6Pbbo6?=
 =?iso-8859-1?Q?9noS+LwEPRK8orkcPMSA45E31T4typm97EmbwJyIcgOeg12hacfprErH8l?=
 =?iso-8859-1?Q?1X8FG1/dbXKClCGDYDNtw/kInVrXYFWq5cL03bmXueH57b7x93cl2Zpfup?=
 =?iso-8859-1?Q?sIbp9Ar+fnf0Lr+DTC8lfd31LjekDAfSw7ul3+4q8n2UyU9pJvHnDBg1bK?=
 =?iso-8859-1?Q?Aq99xLlGoV+FzX7w/zjB0zyIDnaSRWtD/wkiYQZlLCaC8q2cS9V330v+0G?=
 =?iso-8859-1?Q?fQ2RxF/uONwjV1jOr0sCcdfGzqmL+l4i7L0DR06z//0kTex8BQ/I+BpuYM?=
 =?iso-8859-1?Q?K9r2Jh3P9ex9TeSdWC5GA/Gi1VOEp4E9mf9JYUOTVNQ45PzVevldRT5wCR?=
 =?iso-8859-1?Q?kbum9dZkCrtwjcWho3sNifrgVfi0FfjSgYjyeyWMn3dcC+yvBJjV2kig43?=
 =?iso-8859-1?Q?BuAdQL6Ljp1jSelVujc9rWyXiUFwH9JmTMDQZvpJxWsR3tgUmGkLV7+UEV?=
 =?iso-8859-1?Q?MNB1Drbe3npkmDYu8+vlX9WsE9dZB7JTqjs3ZNSjeC5kgVV9VFJKasRLuj?=
 =?iso-8859-1?Q?vlecL4Y0GkCc0v77dPKlHhu2B1koQhpKIEtoaUV6y6vrsuMgU5p/1r4ViC?=
 =?iso-8859-1?Q?knVkytxBF2MeTGjW+Lq67PPHgrhe/Y/2ABqaSMCqNYSriEfqp0lUd2RvDF?=
 =?iso-8859-1?Q?qUwO8SUxap03EQymbcxfEB3JOl3fCaZotHWe+JWx2tnMGBY9cmdLuIqKBF?=
 =?iso-8859-1?Q?MdynKhquaninw77bqYOyKXf0KFM0mzJOBJsW8atXeBmmT9q8awC1//s2uf?=
 =?iso-8859-1?Q?jvfVLfthUEuZx+3gHktfMPaKAzFXfN9AYn9pBBwSvnFOovNEZ9Gx/3tXH5?=
 =?iso-8859-1?Q?3+i0hfOaPGo/cKKOWXq4X+26UabXCw1N/ugyG/3OuLm040tDDzoxsLqmZq?=
 =?iso-8859-1?Q?E3/tDIavCWF9qDdoJBd3tZrFsdyikpiT3pmSyqMNLIxz1wwiEp/mb4cjXA?=
 =?iso-8859-1?Q?QFT0aS8MCEuoGTy2YKREiX6C+OQVdQwMIRNDTNPfnOwbffAtPvzqstoRuj?=
 =?iso-8859-1?Q?/yjXIT2EWIDeqR1TAFUZ9o68zbwHnyUVlvi3ttBfh4JqEoDHJ4Qc5PfACf?=
 =?iso-8859-1?Q?fvWcNk2Tmi297PScH7BQmj02JmCyE0zvXs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f79a02-a75e-400b-9284-08da7bd32601
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 19:53:23.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3ZNonURniRryi5C+upAHnJ7FtVoXKyEacsSia/bP2k3F+4E6/aCq0bz4xWXDoTR0WHZvHsU86MxK5j8kor5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5549
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thanks for your reply.=0A=
=0A=
I'm running on a ProLiant ML110 Gen10 with Intel(R) Xeon(R) Silver 4210R CP=
U @ 2.40GHz=0A=
=0A=
I enabled the dmatest driver and the ioat driver and see this when I load t=
he dmatest driver with=0A=
modprobe dmatest timeout=3D2000 iterations=3D1 channel=3Ddma0chan0 run=3D1=
=0A=
=0A=
=0A=
[ 3527.129243] ioatdma 0000:00:04.0: ioat_check_space_lock: num_descs: 1 (1=
:1:1)=0A=
[ 3527.129256] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cook=
ie: 0 flags: 0x0 ctl: 0x00000000 (op: 0x0 int_en: 0 compl: 0)=0A=
[ 3527.129268] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cook=
ie: 0 flags: 0x3 ctl: 0x00000009 (op: 0x0 int_en: 1 compl: 1)=0A=
[ 3527.129276] ioatdma 0000:00:04.0: ioat_tx_submit_unlock: cookie: 4=0A=
[ 3527.129282] ioatdma 0000:00:04.0: __ioat_issue_pending: head: 0x2 tail: =
0x1 issued: 0x2 count: 0x2=0A=
[ 3527.129289] ioatdma 0000:00:04.0: ioat_get_current_completion: phys_comp=
lete: 0xfff00040=0A=
[ 3527.129295] ioatdma 0000:00:04.0: __cleanup: head: 0x2 tail: 0x1 issued:=
 0x2=0A=
[ 3527.129300] ioatdma 0000:00:04.0: desc[1]: (0xfff00040->0xfff00080) cook=
ie: 4 flags: 0x3 ctl: 0x00000009 (op: 0x0 int_en: 1 compl: 1)=0A=
[ 3527.129310] ioatdma 0000:00:04.0: __cleanup: cancel completion timeout=
=0A=
[ 3527.129321] dmatest: dma0chan0-copy0: verifying source buffer...=0A=
[ 3527.129376] dmatest: dma0chan0-copy0: verifying dest buffer...=0A=
[ 3527.129429] dmatest: dma0chan0-copy0: result #1: 'test passed' with src_=
off=3D0xa64 dst_off=3D0xe7c len=3D0x17ec (0)=0A=
[ 3527.129439] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 9523.8=
0 iops 47619 KB/s (0)=0A=
=0A=
=0A=
Is there a better way to enable tracing to follow what the md raid456 drive=
r is doing?=0A=
=0A=
From: Dave Jiang <dave.jiang@intel.com>=0A=
Sent: Wednesday, August 10, 2022 7:27 PM=0A=
To: Don Brace - C33706 <Don.Brace@microchip.com>; dmaengine@vger.kernel.org=
 <dmaengine@vger.kernel.org>=0A=
Subject: Re: Question about using a DMA/XOR offload engine for md raid5/6. =
=0A=
=A0=0A=
[You don't often get email from dave.jiang@intel.com. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe=0A=
=0A=
On 8/10/2022 3:45 PM, Don.Brace@microchip.com wrote:=0A=
> I have been reading the kernel documentation about using a dmengine provi=
der/client to see if the md driver will utilize a DMA engine when doing XOR=
 and Crypto operations.=0A=
>=0A=
> I notice that the drivers/md/raid5.c calls async_xor_offs() which is foun=
d in crypto/async_tx/async_xor.c and it is calling async_tx_find_channel().=
=0A=
> So, I think the answer is yes if a DMA engine is enabled in the kernel.=
=0A=
>=0A=
> Is this correct? I did some tracing while doing I/O to my raid5 with=0A=
> crypto enabled and see the above functions called but unsure of how data=
=0A=
>=A0=A0 flows through each driver and if I am even using a DMA offload.=0A=
=0A=
What platform are you running on? There are some ARM SOC DMA engines=0A=
that support XOR such as the Marvell chip (mv_xor) as I recall. Intel=0A=
Xeon platforms supported that long while ago. But that has been removed=0A=
since Skylake. If you do a grep in drivers/dma/ for DMA_XOR where the=0A=
driver calls dma_cap_set(DMA_XOR, ...) you can see which drivers=0A=
supports RAID5 offload.=0A=
=0A=
=0A=
> I have the following drivers loaded:=0A=
> lsmod | grep raid=0A=
> raid456=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 188416=A0 2=0A=
> async_raid6_recov=A0=A0=A0=A0=A0 24576=A0 1 raid456=0A=
> async_memcpy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20480=A0 2 raid456,async_raid6=
_recov=0A=
> async_pq=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20480=A0 2 raid456,asy=
nc_raid6_recov=0A=
> async_xor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20480=A0 3 async_pq,raid=
456,async_raid6_recov=0A=
> async_tx=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20480=A0 5 async_pq,as=
ync_memcpy,async_xor,raid456,async_raid6_recov=0A=
> raid6_pq=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 122880=A0 3 async_pq,raid=
456,async_raid6_recov=0A=
> libcrc32c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 16384=A0 5 nf_conntrack,=
nf_nat,nf_tables,xfs,raid456=0A=
>=0A=
> Is there a diagram somewhere that provides any details?=0A=
>=0A=
> I made the raid5 with crypto using=0A=
> mdadm=0A=
>=A0=A0 --create /dev/md/raid5 --force --assume-clean --verbose --level=3D5=
=0A=
> --chunk=3D512K --metadata=3D1 --data-offset=3D2048s --raid-devices=3D5=0A=
> /dev/mapper/mpathb /dev/mapper/mpathc /dev/mapper/mpathd=0A=
> /dev/mapper/mpathe /dev/mapper/mpathl=0A=
> cryptsetup -v luksFormat /dev/md/raid5Crypto=0A=
> cryptsetup luksOpen=A0 /dev/md/raid5Crypto testCrypto=0A=
> mkfs.ext4 /dev/mapper/testCrypto=0A=
>=0A=
modprobe dmatest timeout=3D2000 iterations=3D1 channel=3Ddma0chan0 run=3D1=
