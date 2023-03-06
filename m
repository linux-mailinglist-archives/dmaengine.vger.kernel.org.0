Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1F6AB81D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCFISt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 03:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCFISs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 03:18:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D838A60;
        Mon,  6 Mar 2023 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678090725; x=1709626725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tp8FGmpvYhJ6rzYO99Sj3Bio7YJFrDzgtal1l/iaTuM=;
  b=bUCwYcN3M+ufrT/I9fly4f52ExgXx+lGI8OFSewijb+og1LpD0t2tqoq
   xjX8xMLlF7dQjWVM/zNk1stAaIdlT9kbJq767pDKKtTTfyIZ2Gj71jv7d
   vREa2wU6LvIEHWZWqtkFxtnYO+6ceIlshjMJhqIFcNBwg/HTbyOLF/QKU
   6n8Yt9o3rt6z94qjgikqJHA5TDCJD0PdqZQqrxTh7ig3G/FL2WJIrZknq
   ZEXIGEAadgYQiwCCfttazDFf3LuskX9/W4AopSvIRIAiNLVoH6W2dq/+E
   B/bySeFp0bCQfPAS5AOz5lqaCbcDAa/hiba/HApJfrNklO0bvGyYjt+x2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="319323779"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="319323779"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 00:18:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="786119095"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="786119095"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 00:18:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 00:18:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 00:18:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 00:18:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 00:18:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvzY3051+lmaULIVfq7BFFTch4Ai+WA+sEL+qaA/P8AU3610bn4LHMD3cQikOd6x0/eZTZxYoXRkXBdpzD26/xY60WmhYKUM9+SCvuTw6E6vqXsTJBe8f+vyWOdnaZ0vn2v028AHmi3gHKr5malrS2RyJdH5no+iXk9IpL8mE7FZoPJBzyJy6InQ8eZoe/6OyrEQK5sRx1vuiSZ/F9C82C9yfyvMB282STOOXwkQ3AKmcObBU0Vu0FlCCzgvlly5l0APCE+yUm5EGknMjwHvh9JVNZ4Q0pNGe11Akz3CB5rGZST3Nyz1Bp8u0lKqJEcl9cKsRXYMo+alPtLVXuKmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp8FGmpvYhJ6rzYO99Sj3Bio7YJFrDzgtal1l/iaTuM=;
 b=Cns/xAwWdVK9oRxKg9DTVXjQPAt3dzU5qXHVLGS+e7l4W8O6cMFYpMlKCY25tgqDtHN7yrETUhSkeivIQ/GeEjEkFnsg612gnnDa0O8MTB1JAecM/D6XsFCmx6rruPbMS6OK9ztMgzLrL5B3/DxrdEKGTSPA/0q76ghIGPergtrnejjruMUGgPMSRqpDyDhJaLGWKB6h2p2H0st10P71L0fFX+Rn+9taA4BpOo+/4bPSobC+omiA/POLYKphHvpgXnP5MY6sG6bO/f53Avw7jIjTTSALfCMFoxXZx9kV6+pu1kDB66/kBWQAElkn4OSU2nPR08W92MY94ituPuDI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 08:18:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 08:18:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Thread-Topic: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nhycAgAEDtGCAALghAIACQocAgAHpPMA=
Date:   Mon, 6 Mar 2023 08:18:37 +0000
Message-ID: <BN9PR11MB527649B07E006466882F3D278CB69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303083512.663ce758@jacob-builder>
 <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
In-Reply-To: <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 19d158b9-0a00-4391-7fab-08db1e1b633c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGY6zmuRhRv1bEncaIcMCSW/gOQ2RTTTifmH3HhHWGKOm+wDvZfHN1PebrbvNVZsdcNiQ/ic5SZVk/JbAdrYSGjTIFjNSNbWHJzzc83ORR/McDnb5umYbmZ61X55vr+MuZ1HGMobjFuHSwj+Zgi0tTNK2llwvTzDwixqQvg+L60PJxPFI1UnLKoPl6x/Y5b0cxHFDGieDgDh2D3GSkmNkxWZbeTTqFQ9F18XjSVSmjiZDcgdKHxLHFPKomTUDeryOZnW9YePkyVR3bQeOydYXtfl+vUj2GspeDjFKNcQyODubfpuRB+K7VhoMXeSmQ4Iwkql4ObqyRxYlCP7NoXWgElfmu8TJ3Dy9+TiHVCUJInTso6X1bXlqHTmbG8uPgdyLjdK8k/V/iCAwTTHfQd8XIov3eGI+Lw89Xy3CNNmhd40XvkLF+/afTssEOg8vRT9ecgIG+rew8iHfD1Pd56o9GZzLvgT/iP1I4F7HwBmQ4poiVwtNTD/k5fHqgcLfIiZ/NsIiCJd+6/HaEIUS0yh6zGT4FQliNDfNlk+aIGQXd75wb/9fm8SXfaKzqysc2WR5p5F/u4iVw4+J3vSg0zr9HWfDVeIbHxvUNO9SfY3LjoW9J4v5kxybc3yRFG9mvcL/8ioGBM24dVCKviwfXgI8PwVO5G3jURVCzBf2LpyB3f3JNrHRXYXjZzpeEjeION4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(52536014)(7416002)(5660300002)(8936002)(76116006)(66476007)(41300700001)(66446008)(66946007)(66556008)(2906002)(8676002)(64756008)(4326008)(54906003)(110136005)(316002)(478600001)(7696005)(71200400001)(26005)(966005)(53546011)(6506007)(186003)(55016003)(122000001)(33656002)(86362001)(82960400001)(83380400001)(38070700005)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzdnd3lzbkcvc3lnSTJJWGJrTGl5RFIxdVVidzVHeFYwWk80b2ZJSmlGdHBr?=
 =?utf-8?B?Wk5TSm50WHZoU0ZrTGdjOSttT0JPV2pLMmlhSEZDQ2tncHlxaVdNNlhHV0dl?=
 =?utf-8?B?dGRjZGtmUnhBVi9YTk5PZkNXYmQ1WTY3a0ZNQmJZMTRnaXRZYmtXSzJwOVVr?=
 =?utf-8?B?RmVvNW5mbmZYTUtyWWpHRGpNWHp3NmtUeTlhWmFUTDhFUUtFUUZWejhRdDRO?=
 =?utf-8?B?OGl1bitHUUhBcnB3NTljRzhPVkJVSXNubzRUMWQzL05rTDlsUm9Id2x6bngz?=
 =?utf-8?B?RUFqYm5tTkovSGxrcTlGNU5BeGVSK0liWGdTc3RwSURuK2xsUHhiUU5Rcjdo?=
 =?utf-8?B?Qm5WQWFyZFVJV2xwYXBUN2h6c2xmdkdVWlZZVWZtOTRtMUlUOHRKbjhRSHdx?=
 =?utf-8?B?SmY4ckM5ek1zSlBYUG1OeDFrbER1Z0pCeC83Z2Z2S09TS0VIcnZaeTFxeElq?=
 =?utf-8?B?Ym4vRUFXaGx2T3BNWmRYZTUrSUlzbjNyU3didGc2Q21PSW9FRnIwREJxcjB3?=
 =?utf-8?B?Wmo1MXFUdTJYb2VpbHcxb1RQdzAyaXh2YktRL0FPN2F3QlA4YmxvTUJzNEEy?=
 =?utf-8?B?Y1ZZeHFEN2RWVVlTYXlNamFiNVhHcldsQzVZb2lVT0NRYXR0RTBkVitPMWtX?=
 =?utf-8?B?U3N6cXFudk5YTXpzdkhmMlRtcllBY1AycmVNdGk4STBidm5CbTZMRDlQM0Nx?=
 =?utf-8?B?dWtmaWN2Rmp4SDVCVU1Dd2tMR2RKWjRCdFQ2K2NnQVJhRGIrN2FuL2VjOUdV?=
 =?utf-8?B?ZHlXN3h4SEZLNXhONXhXdWVieHpobzVpZnZpZjErcU5haUp0MXB3amd2OVZE?=
 =?utf-8?B?OUlPbmg2dmtIZXg1dXJPZGp5bitUeWdEdXU2NlV6ZHZXNDVoblcxb0E1WUw2?=
 =?utf-8?B?TWZySG82WnpxeWoxdm1jd0xyNlZOd2ZONmcwbmY2VnFtWXlSR0RyTHZuek5X?=
 =?utf-8?B?VnYyM1k3UjZ2OWd6ZGVtUFFPMkdxWEJqcmZDcWE2VStUckltSHNWQkJaN2Jm?=
 =?utf-8?B?MlNxZVZHNzJ3OEppWlExY3o5bDdsNHljK3lxKysxN1hrTVpldkpqdGh0dzRY?=
 =?utf-8?B?T3dhU0dOaGFYcHVxR3o1SDVJd1JSaUZDNGxUQ3ovemNqYnRsUnNEKy96OHJN?=
 =?utf-8?B?WStrT2xqWmZ3OWd1MjR2UkNDaGg1a2tEY1ZBTFZHUVBpZGlTM3o3Q0QvWVlD?=
 =?utf-8?B?V043c2lPZ3M4UFR4RytjTk5qUnIrd256WCs0WEkrK25QZmZjSkN6NXlvYTFO?=
 =?utf-8?B?aEExaWRqbUZhalFnWXZYWmJnZnBydk5nZVgvSWhRWEYyYmxqNUM4MExtQVA1?=
 =?utf-8?B?RXdFTTJrUFJoR2FPZEFET2k0QnRMSHFQclRWaUtHMDN1SE9nZ2prUjdaYWRo?=
 =?utf-8?B?MC9HNXFRQkEyN0VYaHVzYVpvc1hvbGpING5Rem1EQldMdDZvVHNpOUU3ZG01?=
 =?utf-8?B?amw3bVVqZnRPQzNoVi9QSGtsa3Z1R2F4SjVZVkhlV21Oa21mMUxqMXc0a0hU?=
 =?utf-8?B?U3RVaklhaU5WL2cxK3ExL0s0N1NCeWpJTlkwVnVkS245N2RBdGtrS05WV29q?=
 =?utf-8?B?RERTbk1EWmpwRGV4Y0JVMTcvOFoxelZjY1oxaFM3bE1lNDRQQjZnanhqU3No?=
 =?utf-8?B?NXgzSVRWVnl5TFBWL2tOcDBHWWc5T0NORVkvTUpBNytnSlc2dFptWGFmUUtk?=
 =?utf-8?B?bGpPZzh1dnlldGFSNGltbzhGY2c0ODRVY0M4aG4wakVPOXF1dXdOLyt4eG5I?=
 =?utf-8?B?b2svMm5MSFVsNktGZGdIZVI3SVRKa3RxWlZCbHJsOVU3V0I1ZWM2QlA2bXNK?=
 =?utf-8?B?VW04dzhoTW9aSEZ2dDI3TkxUZVdtSG4ySDN1RENQR3h6QmhJMjlac1ZQMUND?=
 =?utf-8?B?c0NLMEh1cC85YmhKKythUnFCZUlDWmV3dTVPcDhZc0p1NDRjSWpDM2hVekNq?=
 =?utf-8?B?NEkwU1c4czFPS2JuTFBxdDlWMmZER1hxa0pTalFERlExTlJ3ZSs5WEdCa2xV?=
 =?utf-8?B?c2VRcDlab2JhM1V4dVhFVUYwVmZNL2F1djAxdkxJb3hNZ0JvWGhoKzdKYVBT?=
 =?utf-8?B?ZkNzd1NXU1RkRjdCUlM2a3J2OVhvSXRHVkhYaW1PS3kwOWJ0VGl3dE9YQ2JG?=
 =?utf-8?Q?z3OjbEkMeI9keXiLBdtGqTcDR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d158b9-0a00-4391-7fab-08db1e1b633c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 08:18:38.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJGaHeshBmA04and6w8sZIkkAn9D8aeODXtDemLbFniqyZkmmFXp5sKufnfAYh5fuTcpMUgDhb74Grqq68TCuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIE1hcmNoIDUsIDIwMjMgMTE6MDYgQU0NCj4gDQo+IE9uIDMvNC8yMyAxMjozNSBBTSwgSmFj
b2IgUGFuIHdyb3RlOg0KPiA+Pj4gRnJvbTogQmFvbHUgTHU8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDIsIDIwMjMgMTA6MDcgUE0NCj4gPj4+
DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJaWYgKGh3X3Bhc3NfdGhyb3VnaCAmJiBkb21haW5fdHlwZV9p
c19zaShkbWFyX2RvbWFpbikpDQo+ID4+Pj4gKwkJcmV0ID0gaW50ZWxfcGFzaWRfc2V0dXBfcGFz
c190aHJvdWdoKGlvbW11LA0KPiA+Pj4+IGRtYXJfZG9tYWluLA0KPiA+Pj4+ICsJCQkJCQkgICAg
IGRldiwgcGFzaWQpOw0KPiA+Pj4+ICsJZWxzZSBpZiAoZG1hcl9kb21haW4tPnVzZV9maXJzdF9s
ZXZlbCkNCj4gPj4+PiArCQlyZXQgPSBkb21haW5fc2V0dXBfZmlyc3RfbGV2ZWwoaW9tbXUsIGRt
YXJfZG9tYWluLA0KPiA+Pj4+ICsJCQkJCSAgICAgICBkZXYsIHBhc2lkKTsNCj4gPj4+PiArCWVs
c2UNCj4gPj4+PiArCQlyZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUs
DQo+ID4+Pj4gZG1hcl9kb21haW4sDQo+ID4+Pj4gKwkJCQkJCSAgICAgZGV2LCBwYXNpZCk7DQo+
ID4+Pj4gKw0KPiA+Pj4+ICsJcmV0dXJuIHJldDsNCj4gPj4+PiArfQ0KPiA+Pj4gRG8geW91IG5l
ZWQgdG8gY29uc2lkZXIgcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uPw0KPiA+Pj4NCj4gPj4gVG8g
YXZvaWQgY29uZnVzaW9uIHRoaXMgaXMgbm90IGFib3V0IGludmFsaWRhdGlvbiBvZiBwYXNpZCBj
YWNoZSBpdHNlbGYNCj4gPj4gd2hpY2ggc2hvdWxkIGJlIGNvdmVyZWQgYnkgYWJvdmUgc2V0dXAg
ZnVuY3Rpb25zIGFscmVhZHkuDQo+ID4+DQo+ID4+IEhlcmUgYWN0dWFsbHkgbWVhbnMgcGVyLVBB
U0lEIGludmFsaWRhdGlvbiBpbiBpb3RsYiBhbmQgZGV2dGxiLiBUb2RheQ0KPiA+PiBvbmx5IFJJ
RCBpcyB0cmFja2VkIHBlciBkb21haW4gZm9yIGludmFsaWRhdGlvbi4gaXQgbmVlZHMgZXh0ZW5z
aW9uIHRvDQo+ID4+IHdhbGsgYXR0YWNoZWQgcGFzaWQgdG9vLg0KPiA+IFllcywgd2lsbCBhZGQu
DQo+ID4NCj4gPiBGb3IgdGhlIHNldCB1cCBwYXRoLCB0aGVyZSBpcyBubyBuZWVkIHRvIGZsdXNo
IElPVExCcywgIGJlY2F1c2Ugd2UncmUgZ29pbmcNCj4gPiBmcm9tIG5vbiBwcmVzZW50IHRvIHBy
ZXNlbnQuDQo+ID4NCj4gPiBPbiB0aGUgcmVtb3ZlIHBhdGgsIElPVExCIGZsdXNoIHNob3VsZCBi
ZSBjb3ZlcmVkIHdoZW4gZGV2aWNlIGRyaXZlcg0KPiA+IGNhbGxzIGlvbW11X2RldGFjaF9kZXZp
Y2VfcGFzaWQoKS4gQ292ZXJlZCB3aXRoIHRoaXMgcGF0Y2guDQo+IA0KPiBJdCdzIG5vdCBvbmx5
IGZvciB0aGUgUEFTSUQgdGVhcmRvd24gcGF0aCwgYnV0IGFsc28gZm9yIHVubWFwKCkuIEFzIHRo
ZQ0KPiBkZXZpY2UgaGFzIGlzc3VlZCBETUEgcmVxdWVzdHMgd2l0aCBQQVNJRCwgdGhlIElPTU1V
IHByb2JhYmx5IHdpbGwgY2FjaGUNCj4gdGhlIERNQSB0cmFuc2xhdGlvbiB3aXRoIFBBU0lEIHRh
Z2dlZC4gSGVuY2UsIHdlIG5lZWQgdG8gaW52YWxpZGF0ZSB0aGUNCj4gUEFTSUQtc3BlY2lmaWMg
SU9UTEIgYW5kIGRldmljZSBUTEIgaW4gdGhlIHVubWFwKCkgcGF0aC4NCj4gDQo+IEkgb25jZSBo
YWQgYSBwYXRjaCBmb3IgdGhpczoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWlvbW11LzIwMjIwNjE0MDM0NDExLjE2MzQyMzgtMS0NCj4gYmFvbHUubHVAbGludXguaW50ZWwu
Y29tLw0KPiANCj4gUHJvYmFibHkgeW91IGNhbiB1c2UgaXQgYXMgYSBzdGFydGluZyBwb2ludC4N
Cj4gDQoNCmp1c3QgdGhhdCB3ZSBzaG91bGQgbm90IGhhdmUgYSBzdWItZGV2aWNlIHRlcm0gdGhl
cmUuIEp1c3QgbmFtZQ0KdGhlIHRyYWNraW5nIGluZm9ybWF0aW9uIHBlciBwYXNpZC4NCg==
