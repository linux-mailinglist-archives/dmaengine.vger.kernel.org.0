Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B885A0769
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 04:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiHYCj0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 22:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiHYCjN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 22:39:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055349AFCD;
        Wed, 24 Aug 2022 19:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661395151; x=1692931151;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=LTq90x2q94T90Yj5vhnELovUojbO8AxNxi3xPPYIWaM=;
  b=UzVAz8jv8aEoWtTLdT9gJoQenUKJ8UwxOkJQWlKpWcMkjcSjFK7IM6VE
   CpX0EI9E8OKTKZmxIbhGdoXsweSZcDAYCsaigG1MZABIalmIw/2fC2ufc
   sWtyo714ef3xSr7xIZ3T4YbcF/HpEuEGip6UZIwkQjC/JhaLDlkXnwatc
   5PpxGcumGkmjz/XZH9WW6ZaL/W67uaVsEUPeicaFlLZv3tzgzrp22HQJ3
   GqggWFSbAwoCd+R6BBknbZENkdzApWmeCDcYt3+MR3Wyv3SVhGn8808Vp
   yT4QfuPe9y/+OMWu5FQbBs953gNtR7jWpOZ53IHmVoz9GDjGwTgSu1lGK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291696657"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291696657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="713303036"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2022 19:39:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:10 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 19:39:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 19:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr5dSZ0aGWH3q4aoOIeQ+zBZWAbHCNqvHOBGVktsNprF+M8S0ZMydXfrAUrmKq7kMXvIHH5fsChSw/NeYU4AAPCD6w2cATdDQ/VvOAPEUXHyRCoPqG8Q0qxlt3PULgMK47dnmEytsxgqKdHAHygW1WkgdNitt14FW6RB9k0kNYKZSzm/PDchesWqwK4HJ8ahjRL2l9IrFtMoF61JDGfXnD0eZUqNfgEBirbnSYOD/ffHow2Y1fhyVXATIhjHzl2Nq5QxhQDMwIdfssVjFVnTLF8sPyg2omyVCNWidsOJ8dts3I/mmIDOOVW8w0+TNgvbybiqF+JLJEXELSESyDW+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTq90x2q94T90Yj5vhnELovUojbO8AxNxi3xPPYIWaM=;
 b=OboC0Bl/rmGCRisrmuXOsDvomkFDGAsx3JUUA78oYMEnSJnJDpLqGiOADzY1oyhUD5AaQ9bxjH2+tR970BGrah2/Lq8wdPNks1A70CnOcisQSoEeZ2HGp9N9ksldsDFHrTzek43dp38Aj/ZX2MC2+0dV/plSQAp2cmeL4Nw9/Lvucaryv3ekFla1LqX1TtOf5VbAfsZaPrJIkPJR4BgQwkFv0w6GumB29Px3kvae8bEGnpf6LNbu4lmNCmtqk7rIK4xorTaacIEkUb5G3XG2jWFJfgCsftHPJwYTjx24w2xcaQPWRzygw+UelRQ9RXdBlZgye/yW9ga6yGYiOLDhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3674.namprd11.prod.outlook.com (2603:10b6:5:13d::11)
 by DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:39:07 +0000
Received: from DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42]) by DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42%4]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 02:39:07 +0000
From:   "Zhang, Li4" <li4.zhang@intel.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Zhang, Li4" <li4.zhang@intel.com>
Subject: Recall: [PATCH v3 1/2] dmaengine: idxd: Fix white space issues in
 uapi header file
Thread-Topic: [PATCH v3 1/2] dmaengine: idxd: Fix white space issues in uapi
 header file
Thread-Index: AQHYuCvZ+MEs8/KvwkywinHuYgwGEg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Thu, 25 Aug 2022 02:39:07 +0000
Message-ID: <DM6PR11MB367408C7298308F96BA725F0AA729@DM6PR11MB3674.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27580822-9671-433b-24f8-08da8642fbee
x-ms-traffictypediagnostic: DM4PR11MB5488:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 772jbGWDRFJlqGIa/ibr90Qe3BgFazUVuMd8iUtqn6p65Vi4kmTFzFZrEz6umd+VsLK9tyH+isTzamMzTNmZT8N4Cks6qTFdFP8v5kk4bOx7G5hM0br4SrPwMaq0zuVLeOT0/xXYNzj+7c/qfe60HKYvx6lA/IQ59u3zVSvVnkbT/PVJdh9OcbAci8bzxef3kKukDLctQCImEq3n83fliaj1mkcdKAzUXfMMTyzxbHUzqVEhgtKazEh8CdRPYkSILX4kSMo4U6ztLZwEm230uNOc9AWAnGgyWu8CFZkuspaUszyjdWFrsKXvNxLxJEh4uzePnCD/LH66vNzL3lE8BzbX/sSJSAULewgv34+lfF6fzjJziKQ9HsKfxkvpemvTyMQfRynlgqB4+i9t9C/UnasLcjJc6p7yX4SrzZSP6zzJSHvOof68vFI8NaM1uROq/0GrEWwDVGz9kI8Mo2rPq2weEIb7gT/Dv3XVenDBtQCQAWYKb7JbsiuSfn8mYwjwkUAgZE9PVebobr5PLQlTjT38TDrSSDSG2R19i1QteXxYukzo3+MhiDvk9emVa30aFEO6O4dYZYXd6iTQgGXU5gIuk5U/VOk2MGWY1D8semlKBgeRuR2IIrH/8accuVSzLbZV3Avr3i5CAomANV7+Fn4LOmuh350Iuy2YVK/cRq9SqVb8vvq90bDpqQc8i/41K65zfbFcUqK1nmODdG9fQlxUJdalncaa+n65Gvn0nohJXJXmGOuDZR8PQarH2vNBb8xRq7RKALR4q4mx+B/gVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(376002)(366004)(83380400001)(186003)(66556008)(66446008)(66476007)(66946007)(64756008)(316002)(8676002)(54906003)(38070700005)(76116006)(71200400001)(110136005)(4326008)(26005)(9686003)(107886003)(41300700001)(5660300002)(558084003)(52536014)(8936002)(33656002)(478600001)(82960400001)(122000001)(55016003)(7696005)(6506007)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b24bmkgh8ecVRZEkbxkl7maO74JsuXGqTCF+xLzOmreJCMc1mYxNh+x0tmM+?=
 =?us-ascii?Q?GRoQ+pnMkpC1nJ5gFwnQVuHEum4IDo0zzl0A5feGzSo6h3Va9oAxVtgEpWE9?=
 =?us-ascii?Q?SEU6SLb14n56mY0QXHdDvzMqCEOWoa8Hvfm6lDVo3+0YwLExh7J2rFW5IL3+?=
 =?us-ascii?Q?EyEku4hm4qXg+blYnXZT6Tt0y6PdCuQBmUPF5iKN3TnHtn1rZdce2ueucd/n?=
 =?us-ascii?Q?+l3G+MG802bl1q1zr2kSB0LfITgi3NVIlLGeLaho01UZmbN/xdswTnABy35s?=
 =?us-ascii?Q?1LxVrAcm6uIY47UOBUoa9un7kN+1sgxbusXMsZGPfi2b0j5foF7kJZ2EdYs0?=
 =?us-ascii?Q?wv1qGvV7Pb3ek/4iP0tGB9+akacsjDGvdkiHOK5a8/VuCJsugOY19+REATP4?=
 =?us-ascii?Q?oM2SGDrsgZq4z4o5LR0Q0FoUhr+CVjt0sEZyOAc6li1UvteLdIjSxySizP50?=
 =?us-ascii?Q?MxO/ght7I4AmlJC0jNJtpFVqjBhv/ro4cDulo6JnhlOLNiv7ADJAGJten4qD?=
 =?us-ascii?Q?jB0RhTSYWmx3zPyFgh4IviW8F++SWE1wdD4/bkNwnXhxwJXb3Ea/aFz3bfEo?=
 =?us-ascii?Q?R89aF9p0TrcU/SDAMRN/O9vcNn9l2Q4hSbZq2mGgrgrg9Kgr5LvuHdCVZI7i?=
 =?us-ascii?Q?JXA5GwGjsU8rocebJaDYcql9ffObas2W6beyx71GEMI+k63Uu22LAJbg6NhL?=
 =?us-ascii?Q?C+VfqnhQ4y6EmHHRNGyBVrhBtL2p/yTAF2BH132yBJLVoU+oM+2JupA0aTyo?=
 =?us-ascii?Q?HEtcvBLDPxqEntf9Gbb1FAfBLLCZmN+KXHcCtq+Y/SZkG7KkGufZR9nkDzFM?=
 =?us-ascii?Q?H0sAgiN0DzoXWK5ue29vhR7trPdbhlWzDzwOEF9k9EfD3yPnTJ0msT3zTOdI?=
 =?us-ascii?Q?TZfBiyA2Nr7bOXcW+AoVTBVCZCSwj8K8YW2PaqZw8MymeBBqQdC0zN6wDzT8?=
 =?us-ascii?Q?0Odat5mo/laDlEwOC2xOTPLElz9MzXfw11NBw0QD0GRam5x5BgPnahL8y3fJ?=
 =?us-ascii?Q?CHLPJ9UT4LfZT1wprdbv48XYS6f/bfMizVgh/6dcCBySxcEpFlkG45FR0H/G?=
 =?us-ascii?Q?9GVlC3yEnPU+27/EnXW1D9E4vBQKiDcNpjyq0vva6rCPrImKmk5z8gHYDj9s?=
 =?us-ascii?Q?FcF6s/ql6dOAXsjY877CI0l0oKMLBkbGAM3gBe1GmvXm000Jk5s+LzgQpfde?=
 =?us-ascii?Q?2QfceBHjlZRqIYJKAJiPgbRwmIDrLaX2l8Ne3D+ZD5KJWOmPKI0Gf6m3M6+Y?=
 =?us-ascii?Q?hKSS+j+jo8ntqVM4pVAmVXUfCPl9te7/40Sf5k38wglOMkphZ6sRzH7XBzqQ?=
 =?us-ascii?Q?Odg+g3ogRCCF2OAQF7i3bo6/qdFTi2lZ1L+EI1DkQsx41OgRx8MCxS/689mL?=
 =?us-ascii?Q?cjWttnmJb+GEcYi7yl5k5ecfHSLi/rO1Tt2/NVDLeOxgNtGunJySCMRnbqRx?=
 =?us-ascii?Q?bNbMN8E2cYcESBi7JXHHLMmHgegNcHqgQjEmmqh6OK8BfbD6LWs54JDwjajA?=
 =?us-ascii?Q?M3n/nr4WSsoizEwsNUSLspNzrKaPjONHR6Qerzjd9Wc/iOknm8hP55h4BGHB?=
 =?us-ascii?Q?taTvMvcnA/hGyZXWGytU3RJUyzzPtXU/MMNPbGHY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27580822-9671-433b-24f8-08da8642fbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 02:39:07.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0oROoXrND6oxjJWy4cjq+GTFWuHC0koNZJ8zQxPfuAqJl3Fq82/oPylC2MztU6GZHXR0t6qEMnSigyguRnZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Zhang, Li4 would like to recall the message, "[PATCH v3 1/2] dmaengine: idx=
d: Fix white space issues in uapi header file".=
