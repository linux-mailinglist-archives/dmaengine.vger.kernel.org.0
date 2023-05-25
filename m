Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFC7105A6
	for <lists+dmaengine@lfdr.de>; Thu, 25 May 2023 08:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEYGZU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 May 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEYGZT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 May 2023 02:25:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F2187;
        Wed, 24 May 2023 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684995918; x=1716531918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/fZaA3OeNaH+Fn7NurWEQQWLyp2o+Q/D2z9xfy4Slk=;
  b=EJs6N901XMpiooxDsLwE3dSEhGSFl55XeP42TMjGyeHd53vAU4wbqQ/I
   qnfOL14Wbxhgwvri6/Kv/K1SV7dAmfk9gBlU0g1cx6/xLAOPo3XG0cCZx
   xQASoZdqC7pT2vbNlw7Y3vFJXpoEYrDKzF7DPA/Ri4Lo3FZG5SBA7QfA3
   Vr0HAKhCa+JkZzkK7q65sj6/+FEp5oJopmX0RIdfdrvADlG2o1LarDAMV
   ISgLS5fPbBYxCWpwkZ+oNicKHyZVrGR3e7F2TEDakTQ4WoJ5FOTZYxWIz
   XI00pTkwQdC+MKGXTbRcsZDh9Dw329YFH6imkrk9z6Ydzuuei9EV15xnD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="382045061"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="382045061"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 23:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="1034851213"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="1034851213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2023 23:25:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:25:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:25:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 23:25:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 23:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jva9LJdM1N296U5aibFdHpn1oJrp+WsZ1gVW6v/AzU4fNcHI26DLXgsXQVEzH4WKDMAh5qWhAs7wOK8gN0zaY3lJDkkrVP4BW/fYeovdhg+6vaNkbQbxJIaYNJqzQ+QsKIQzabLjJmpc8N0Q4JIGten62SFDoxAUGbo0TIptbgVGy9mly6N8qcJK2NSKlCSS5KYbvWWiUrSolo4X90h6SakqrVQ0PofajX2q2fvzMUx1W3xlZ7Mry94/5BP3xDmQKro9FKxyIfMf2nyb1BjEuyu3gNFZwxUmHSRhe4VuVkiTanXnwR6h2q8flNlkWPpYU7d7+3Fe6qvpFMv2ye6kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp7k7C8nOBh3xTQeSUu2fExpIKfRey6JXwNtDrV3haw=;
 b=Zh7PuZUxx8MEUr0unoknQnAkJPAvpceKaf881wSTArbyF9+aEF54ZiCBNWpJKOQshcnbKqvRuQppMI9fmuHWIjbLsdOnfz5ZymGSgNhqr2RYbe3b2+1VeDNj0CpvAyWoLiCs9B19taqVd9suucuOguDxLG+67m6KnDFRf19thbcYYDz5E4hprg7MEhVT1M+Yonerx4jxkxw0T/wVFOetJOLE69u96fRTYRv8L9q4EjR215IJPRkU8OJMqMcs5O4z2Q7GpfvzRTSnADjU5rtY+xXDELEXeoWQ6HZhCyMni3OpjNZIEw2xc1VLPeKFXlkL2XxIeRCcp8uKzqnAVfXpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 06:25:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:25:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v7 1/4] iommu: Generalize PASID 0 for normal DMA w/o PASID
Thread-Topic: [PATCH v7 1/4] iommu: Generalize PASID 0 for normal DMA w/o
 PASID
Thread-Index: AQHZjZxIUQUJt2bUzE6SwDaFfbV6eK9qh86Q
Date:   Thu, 25 May 2023 06:25:14 +0000
Message-ID: <BN9PR11MB527657229485CA954EEFD7E38C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-2-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230523173451.2932113-2-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5520:EE_
x-ms-office365-filtering-correlation-id: 05594d48-9497-4a9e-02eb-08db5ce8cd35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+Fv3CbcO8MSciptUtF9xpn3NIIHEqXdgAgI7VYJj278yTxVW1c9i70mNGLByIE1fCPinTFd/tefsPlPOXr8dKHCbgXA/BDKjtZbADSiMMGbA4Wl0hp98nd4kvKVueUKUWCHEijntjr/m4oUCtcX+3tkmXxpdAsGme+b+1r8XvPTdzH1HFWWI4hJ0LJTwv4X2EYBcwNNIt3GyVtmoVQKAtE8DExeenLuRf86A+Oiikys8J6PGDTTCzPh5BU/jGIsQW9UGIcqInFCdsSD2RdyOV0r6OE70ehIwHFJ142GDTyql7KrwPqgm911lQYy99Nv5fS91ZoM4q3i5czeaLv3wBT/P6Dn1YaJ7+btU6uuvxoruHUGEUJIlJQtmVXwX2jXjpfqZly2IDdxcQ7oMAb6quyg59jAe2OzuYLSCuspDUtAo+eJp226cF5LhNzita6p2fCuC/p8aO78gHfrSJkxh6qkAujSCAUYMDya+OA506oaf5vdM+H264WgDe57SAPH3hLJwHoZMu+sRTkQZE914J4x7Mp1jvrTBiyXdpRIJjzTM/MX02p425Ss5MsOMhPxGDKZoLgvoxNio3w8IK8/Ao/KZxU+3lhCJ++tvFn7g8HSAu/GwMdmGKjHK0yYsuntLFBMabKumxmdFZ4FXD7bzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(54906003)(110136005)(4744005)(33656002)(2906002)(52536014)(5660300002)(7416002)(8676002)(41300700001)(66946007)(4326008)(66476007)(66446008)(55016003)(66556008)(64756008)(7696005)(76116006)(478600001)(71200400001)(316002)(8936002)(6506007)(26005)(86362001)(82960400001)(9686003)(921005)(122000001)(186003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GLYBIF2Csvyqqwe2QCbBl92RKdFL9QGga0b+Z/uiXwJB6hHyXXU4rvRnXCWZ?=
 =?us-ascii?Q?H4aXWmi9T4FCPXB3+Gh9+9E7MRNniewCjw8OglCW0igEBGkyG8xG/RY3pIGL?=
 =?us-ascii?Q?FJXkEEur8wjQSO5M00fdaMJZ3JTFqqUj24HV8pZNNvmffFL607wBGnkxGXkS?=
 =?us-ascii?Q?T7PvCqLFOW8/1ak7hNFmRHJMn7Hf4pE/FmDX1eEZ7hPOyPBrQ0aApOCEejLh?=
 =?us-ascii?Q?u0MGW4kp4v8MikXMzc96HltYJb4AWOZX/tvs6RBF27DKusaneGlvd1en/q06?=
 =?us-ascii?Q?SkbMt8+8n1YyRo30w8dzKosoeg0jYk1KJvkaM3nUGkbTeWLt3lNSTn0owZRV?=
 =?us-ascii?Q?lk2x8sewqWaTB4lif07lP/t5tnfSiCgaj+Yl4LkNQ0MQb2htMUn5ZcmihxVr?=
 =?us-ascii?Q?fiDiHFtjTRxa0bl8e4xyOwH+ap7uKk8pPElpNjUhZ4AVZ/F3BZO3Fl0VVmQf?=
 =?us-ascii?Q?zBWm32ZTtKz8CMEzWhw0el/1JXT29LXMLpkTy3wQ4JwfazO4OWtD1kEkdXsJ?=
 =?us-ascii?Q?LKKjl/KVP36LHmjysbCtJd3RCcsDIlnjiqptCberva0Ia/uLdOZnIKHlplBu?=
 =?us-ascii?Q?8TE+QJ6jnlLAbaaCGW5QOl89lPMX2UfmTFjWBFRVfY9yp9st+hSf0FCiSjCp?=
 =?us-ascii?Q?ccyfNutk/1AGAwVLiKuvNoPbMK+MuwcZTm7IkiMEJ9o65RJ3tOIOkm8N6oXo?=
 =?us-ascii?Q?wkA64QUgUQ46b57JkWlURj7cmNZmNkFCryZmu823MUcJxCmZ5CwsOMTR6P6t?=
 =?us-ascii?Q?sRd5ZfKx7gIEhWy9ZGddXzLtTBvwzmgrr3YMuUtHouLvw/GNSQdZYzAX5AyR?=
 =?us-ascii?Q?LKBN9ZHjiizK/u01ANiSz/QwIeiiM/54w4zWtMzxNebYnW0AFqqXdcoXUfKS?=
 =?us-ascii?Q?am6CEUJDusTvRmGaBsYQTsDPWZBF3RCmVxwHUciGKaJVwstNp0uPI92l43Pi?=
 =?us-ascii?Q?9oNl8wNR8LuFIKWgaj6ffK3N19fQvM53tqUrssL7ktYVAU4v/0m9HEVOksUK?=
 =?us-ascii?Q?vpZqp7fIUvDsQnXQp53ATN2cvxfdmX8TrN65fJBbXQ9bdk/rfJIwL0oNU2l0?=
 =?us-ascii?Q?0sBOcY5H1t1lHQH+Qx+bRHjzq++R5rm45psh6GLiP7sRXTMPPigmslk5xtHL?=
 =?us-ascii?Q?mWMujRqmquve8OWfcUdVvuDs04OJJhDhoR8iSqnmPdU4wkbYC3InRxlj44ir?=
 =?us-ascii?Q?+egnCY3BlbJHOd4DfE86sPbisUX/qNNbWsO3wsjSTcTmSaor/vaVvtJwOiuI?=
 =?us-ascii?Q?LI7u/nzoGvlV+xtJxgmQPVzyzDuC2usO6PhEK/HUZJutFetGPsTETNxztEuK?=
 =?us-ascii?Q?obuc5E6jERoIFma9EMcJz6wamv2fuTOVpzk+QsYGAgLT0085RAat/rwlVA5v?=
 =?us-ascii?Q?YlkOR16bzfA6x0SHV+Jh3XkVQ+1HwYc9Ym9aAnRyTk7rzF9HcWZj4Op8KUTd?=
 =?us-ascii?Q?mz+JiI/7SGs1pLQjAtSOtKG5wBRmkxumwKd3jgHyjpBxaUaO3/pJXf5KxmkK?=
 =?us-ascii?Q?4pKPo4qlp/A1jccq46xzaTy2YaVvaySKbAyDdC3AtHu8TkE27fWhEMsj1WLk?=
 =?us-ascii?Q?3OJgd2XSQtxT54QiQuYngWxRzltu9PwZxKcJhjdm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05594d48-9497-4a9e-02eb-08db5ce8cd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:25:14.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hl58aJLMITQn7r15kuFbLMI3qQj7RTOMWzrN0YUx2CjedLP72ddeBjHiAg23hFsirHJIyBKlGHJLvIdIMrHMgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, May 24, 2023 1:35 AM
>
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -10,7 +10,6 @@
>  #ifndef __INTEL_PASID_H
>  #define __INTEL_PASID_H
>=20
> -#define PASID_RID2PASID			0x0
>  #define PASID_MIN			0x1

PASID_MIN is not used. could be removed too.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
