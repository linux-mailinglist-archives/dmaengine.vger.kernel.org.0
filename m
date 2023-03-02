Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74866A7D31
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCBJAv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCBJAs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:00:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54763B3CF;
        Thu,  2 Mar 2023 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747646; x=1709283646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XUf3M0XYdotDRGYWHnLdcRFrDTabpJHPfrjC6LM8g4k=;
  b=S2T2uCQwAlEk5bQ5TPcTUlNgmYXHWl4egsKgkuxDAxN42IhxipnDEJg4
   qsf5yGVrX0SVIvu32Nn+szJsDpTLwwPUJq8po1GVNPhsZ5pq4y3jFhHgd
   of3+a0ZDClZ5ltzAi/yWgCVTtrD2UH+Y9hP61XEnARh9A3TlfviymZpks
   M+2JlogzZrrHY9QwBtsckTACohLUZ0HGrno1SIJvAx+6flr3PfP5pjuZu
   w/RfSmjhKhldWl/4zQyIOHDWkrSMyqI9IoibMJPZToxCdnbqmzqi+lLpQ
   ES/aqhh0ooLR7A8v/OCRCvPynfGkeZOMkc6gDgt5Dpg7g6OA5U8ka+PcX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314329782"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="314329782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738990730"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="738990730"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 01:00:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:00:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:00:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:00:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 01:00:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoQE9t+atwsS6glVB7tDaVqfQalM+4EdO1B4nJ6/sn4alRjh4kHw8ZmRkd+lXBG6KesN5/9w1ADAoFya7jyn8hrRlMq+MniCyvgVYrLmaET7YsmGUbZ3rIf9FRt5hNQ932yW5Wr3gRgfC5IUetWWtQK7tB0ezC3wUGRfRzvtiAPsY5WkKVQGvI4cRz0D3WrkvcRdQloevBA1Clj8Gxo74olHtJ1YutsG3Wy7+iWx6l+JUlBjyTQi21hySpWV/zXITt6lPzftu4C8WVKjcHvh3xAlxp0cNuaSOn6E3VoCQGAiBKqWmqFrGSwikPhpXAek9Oo3TzfN2lOUXRrj780AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe9z9L87WkmWhk9zZtiDF0v92Dv9NmVpMlqHRhgjtMQ=;
 b=PwTkolB6XtkzqXnKUAjHcTf5ZuiCwsTgEIz3sjzzgTIfMjRtz8/G/REJ2diOJBHRBw0Ug203FatgAk3yRS2R3pMHW90JMGECTt2bL6XVOnnmvnqNhU11isMC/xXzxZTHsvyGE1efqHRFAhpQVr2Wi45KDFGvkHqDyKIJqqrOEeu2TljQF11CPnP9VDFA2HeTkM2h+ztRezeD/eFWpM/Rcz6ia06HBLw8MyZK3vmXGEYSboSxxPo/LeLLtcQMyAPd2jJzY37+xzANZyzF70jn4yKaxjGDJfLu/by9xNXMXGsujZtflQ7ruj2bMDUNNxiFEMp5PP0cvX4Pxts4RS+/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:00:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:00:41 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Thread-Topic: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Thread-Index: AQHZTJj8ilg+Ne3LDkeKESEP+5+js67nMWAg
Date:   Thu, 2 Mar 2023 09:00:41 +0000
Message-ID: <BN9PR11MB5276BE79502EC434DB8405158CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 487a4fa7-bda8-47d5-0218-08db1afc9984
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nl7pXbXT8e+OkfiAswE/dh0nAvqyVT7AdAAOjKyvCThc3ic08OP8qorcglwWqpcUD3K0spH6eribendwRebWlAAJTQ2uI+gDSnHuLDAXHariVGZvn6zds0tUDRs+j7TLm2Hj0WWXYGjsMDpAd1FNLPTrWKtih30AVRo2jyJLRT+8HGIKI1XAWAEeR31aph3IjIzkQP/TnH5+yR6J+FLBTvDLMFLuxxf1vBmpGYdm0N0IO55SKBjlb0OVqYxbqT2MpUaSXiRERC/e2PFz90U3WvqxYCDBFJ5Zbk33AvbkAazoyP9LiMRTuGXkEFY3SFT84tH7QMBx02cE8TdlIFe3uy9wofPuXVoiXBhzTlDTL9FCatyfjcdl+mGX3dTWdweY4PUhXFo/5oE8qEGqvJ2BVrMvantNaYrW+AK+R6ieJEkv18YPpSAqcbSPl7EEe+W+igEWAaBGmOGVdRsp6ZpgXdin9neaGoANC/Oi2MPdlA8DEw5bPZnqKlWcplNr8+Ah3BSXmDb+hKcPQkZMqveWV6zdoR/jGfIRMD9buH8jkcuwpb4AAOm1XzufGLFRe9yn/ux4QNfEiLZmOLUp5Y80kaI6Mxk2glsVvR2fO5q8NqI1ZU+tLRqohaOOxel5pan4XWM6euLbA4wUsx17WOj7Kgxc+YLDXmkHEZu6p8vPbJgwU9zJmD3AVxHU6XkicFZ3yfqyEPvXdZROcUQbSeskBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(33656002)(122000001)(52536014)(5660300002)(8936002)(82960400001)(7416002)(478600001)(921005)(66946007)(71200400001)(55016003)(86362001)(38070700005)(38100700002)(26005)(9686003)(186003)(6506007)(76116006)(66556008)(4744005)(64756008)(2906002)(8676002)(66476007)(7696005)(66446008)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aOYEwX/5vCsIgpQpsiHvPObqTwMi+7uAVM8+0gPfGqrRF/sZxfQ2o4aTJv5Y?=
 =?us-ascii?Q?Lg2u/UrrEzR9EzVIe94UBZEodwF+8dyNYGLOwbnw6XsWSjx29nd8G+ws32vp?=
 =?us-ascii?Q?UBnxxPE592nW6wvrjNKC/eumh6B/WIQB8gSDi/Oo0LwPiMu//eY3mEs9PZ3c?=
 =?us-ascii?Q?anSNRnCav7MJK8tDqTabXXf7hw4IDqI6GSl37P9WVSIJm8dwZlZRhPYPsHAL?=
 =?us-ascii?Q?RLhDe6VFdxF4TNdw/SD5QlS5Z+X0e4zJk+46jS1/rkmwV6bfa3amOAlsBJCq?=
 =?us-ascii?Q?KAak905ikMUdA3qhrNDNlUAK0sV35hTRG5v8alpghQ9tYWuN2SBG61Mcte7A?=
 =?us-ascii?Q?wV7g0if9IU2Rf8J+GXI7AmfMW/FYcw18Jqq2GbOH30/zOq63pKwOQDtTFMgk?=
 =?us-ascii?Q?Q7YyeifqGfzkaBhq3w6RAmgx2WLMqiAw/yT4wv+MbGxvsLAGNlvk8WudYQaj?=
 =?us-ascii?Q?Sak6oa5QoL1OE6/hwG7hA++D1A4GaQOY89EvRLgyFRdMhD0twM85E40lfCSg?=
 =?us-ascii?Q?ifHhGFjRTtU7fuTzbQg5Nzuf8xXEwJrXaUHR13Stuc4jNfXdL7n9kMogOKKA?=
 =?us-ascii?Q?F50BsLhqkcHxz7jCWfAz0ZLwMpLrogvYN/7zmNExmtl9UE3ePj6/vxFG98T7?=
 =?us-ascii?Q?kQsNo/dc/VGATSt/6hT7KTsh7pjOFNJrRKLlju9TIM/JjcodEUtSsZpX0RBJ?=
 =?us-ascii?Q?d9eMIOU1VctxAOGDc4OLXUphBnFTAHJVyclp7n8LN2oH10cpAUTk9+Dzq/C8?=
 =?us-ascii?Q?YCOEDCqQV7g/vbJImNZjAREFunuFG6P81RdkeZjsReh24C5fjH8d1mdsgmpS?=
 =?us-ascii?Q?/QXthBbKqtJRgbr6enSCehCpiIbKaQ9CoZIN5kzVDYrg7lBe11mOlHHK5tfV?=
 =?us-ascii?Q?LqiRE+nBjwOo56x7ddSVzZqeWPbwe8+wMptHt0Uj9VLpxU7+tWEJ0K5Lhhzp?=
 =?us-ascii?Q?/HyNFSB42HShDR284PR0tTDT91hycIfyIPcHjzNGJJGdq0wa7/hWJgkQEqRx?=
 =?us-ascii?Q?MDKLRMSmBFqJukTqtrXB5vx2PrgdtpCserTZCaE4+/bVM4e8VbouqCHwbN6i?=
 =?us-ascii?Q?LfbTr9NyiJxwfH30/e/tfYib1PNhTloHdofJhZ7lIBnwNaEBjmY73OjJNJZr?=
 =?us-ascii?Q?60v5OnrJzX104UxtWKnovFwGGpvz6rvOfUOzDLxGm5Lu5HtK7kr8+Q9WeOyY?=
 =?us-ascii?Q?ko3yCugVpCR22at8D+yG0fbBvidzBAHV6VXsJdW4Vj+pja48CIeUEcSDf7er?=
 =?us-ascii?Q?rRQnVeiSrxdMBWb9nwlKn70Dkrez9fTZIgrsoP8zTejJQcmrcUiZqW0D/Cxd?=
 =?us-ascii?Q?VSkanLqOkoNwSLDFxwu59zo56aAxqulx/2/ePI2rU5RYuVH1xOQ98UGOF3Mh?=
 =?us-ascii?Q?FTYsUw6wdXmHShNIhQPdLZtz7+Ajyfyr7A/0PEDIIpVE7pagxe1+GnXJ7RL6?=
 =?us-ascii?Q?f77YUV0JOU6DXzoG+ek7dQXU7tqYDU3a6LLaiuTrAo6hUN9vFzLjzZH0Rwea?=
 =?us-ascii?Q?+y4aoAl5amYUuHaZd+POe/HJSm/zuRQVzBWAB6/vCJIKG9ynJFz30FyDNDbZ?=
 =?us-ascii?Q?I1fPK4Dwj92fuVAxyft4kj+Be/1DLApD2KCC7aT3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a4fa7-bda8-47d5-0218-08db1afc9984
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:00:41.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFsD5vDPXtYFBtFIJ++H5KuP6kNhaLgZg7tU4erY1lhcAFrJbUW9Y8qt8P/n/gT84e7Is0My/qZyVhdF+rFYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 7:57 AM
>=20
> @@ -1194,7 +1194,7 @@ static void idxd_device_set_perm_entry(struct
> idxd_device *idxd,
>  {
>  	union msix_perm mperm;
>=20
> -	if (ie->pasid =3D=3D INVALID_IOASID)
> +	if (ie->pasid =3D=3D IOMMU_PASID_INVALID)
>  		return;
>=20

if (!pasid_valid(ie->pasid))

same for other occurrences in this patch.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
