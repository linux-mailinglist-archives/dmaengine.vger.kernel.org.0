Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228C6A7DE2
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCBJh5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBJhx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:37:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149B18F;
        Thu,  2 Mar 2023 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677749871; x=1709285871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/CdH0tOwEeJZzusp4FrSZnhFMHOVQ3M9bkSrEkHVEHA=;
  b=LfJTiAb3q7IUAAMk37Qkthz0+0Y8sw8s04vpSBq9Vj4YR3+iDK5dTz0A
   wcAIX+SDWybhi00xRt32wAqTJ1xnQF19UZo7nVerp879WI/hlWGryVDHR
   qJ2YdpifL0AT9IGj4TSR+NmZVfvn0bZ42OwZRGwXnaXusTpHYJPDo7dzp
   sx+rIAxyN1joqblP5chZFAlYIBO5u4aHyE0/GEoGAvCX0257hKFgjUaQB
   nmNbNGa3afV9CRTDTFnyX0cHjP7fE0ENSrsW9sbLN9p+t2BKIbiSs6NIl
   eXwU1Ck91TV9n9Y5T4EtZqv7046rrsbAA1Y4ovFzdV6j79H6TOrRyVnu0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315095816"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="315095816"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674894701"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="674894701"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 01:37:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:37:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:37:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 01:37:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duCEcfDKnDEImqNH0sK7Gh8KCvWJgfO+YttASF2E3lgQ/7iChxM3v/5+i3RtBizFCeodR7/eeOqnSI28O9YGEgPeEZbTJr3MoEmZuqKmbYVjBFiooSq7JcyzmJaVB1HucaXS1iFIekNsTOzM7nK3nnjg7K+E97UPReDMnGlQHPMWeky0uPhjoKDnjnnm83mIQvB5uUpsNHWm+bBvUN1VdEFAqgPKq4WOWL0lzwWMawnLA4VqslOH0z355hlm8D62jbt31r5SEW054eCr5ccx1zbidby/EE+QKBq6QJywihJqb74cKoy/bTcfM2qFunoEi2SKRrxVtPkN2rmGUxKb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CdH0tOwEeJZzusp4FrSZnhFMHOVQ3M9bkSrEkHVEHA=;
 b=BHaBwATY4nY5kZlhPe/jpI47fOVXn04a1eI5kEm9YEhMsmNa9ay6QsFU0kmdfyrsBCrvpmNMo6SCA2weJ7r02X6ONXpA4EVFBHaNTd96uSX3AMJcvDyOgWR13kPK6b7qAbThTEason1ozBTyr73X+E/irU3BQGjRU6D3aobyB/PJnwtTEAc2OGRZoK1vLTRo2CJE+MTKvel9vSQFDQTBgloP16+nkAi81aycpd/kgV3zeRk5CqGSmd8L0lhjhD59XKw3fpajZsi9rw4S8IDJsTGSj7kPh2VWjSAYZQVWHHTSGBvq/lU99fmKiVJ4o5LRotEmxodCBk5oCe/5uA2Jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:37:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:37:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
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
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nNYYg
Date:   Thu, 2 Mar 2023 09:37:30 +0000
Message-ID: <BN9PR11MB52760B805DDD6CC70C0E1D6D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8122:EE_
x-ms-office365-filtering-correlation-id: d4f54c26-760e-4960-4d92-08db1b01be8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5xmUhNIPn+Ev1KN5gvWw+92IybBGm9YzbrRVg4Oo99tyLD5zddm8FF+hbxwaASW3fq4ebjnu/Bp/ux706SoabGrBFvUpe/XeR3eeBmEM/kPwL82Ams0GLLihNUco+XLMzdg8rNBlyXZ8kXnMuNXOZzhWcncbZxqgI4Lw33L7jTp/LqdbBisxeN3bdOZA9oKJetcaaDOVtF1H8MPK0AHiOEgbmVeANnTsxV5zXv0+QkrR0T2JQRbpG68ku2YwmvTl1vBRLCHhnAL++n7JS/EiDM9enUyfzkxXO4mzVHE84FmNp9MBIAwGxddmqhD1Ub7oWI8qC9O/aLacGPfMR+dzUux6+BhgdIbmx98ydZaU1+x9EZgUYC8OTqcvx5y4V7tnrpV52wo+mdmMEpH7Eyjntd5cExCL6AgXA7xPENHYVshJKJD1aVGZdkv//Y1UrCauSjrKLC86pfS1STsX2DXlhxLNVHkRViL/xzgvBRJYYbCtU4rNwngLAWgyI9veeTy5v5B8SP4/QpDEWXmeoEgXrSgqfACZGxXbgkcvxX7nWwxdpbl+PEqf9x0wbXNTA/unwy0en7Uui6cRxg3i0cYFUYjjtGcwITVAyPzatKM/6jR0MdqvB22an0uDAjYFvl+xx7JxpSfEUnmqFBlgr4qsr+f0jlgG/fMgIsUcM3BVHlnnEbM/JHmato9sM+OBB1/WfZg3y3SsZJnkndivEuTCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199018)(38100700002)(186003)(122000001)(26005)(9686003)(82960400001)(8936002)(52536014)(38070700005)(2906002)(6506007)(7416002)(5660300002)(33656002)(478600001)(64756008)(8676002)(66556008)(66946007)(76116006)(66476007)(66446008)(4326008)(55016003)(41300700001)(71200400001)(110136005)(316002)(54906003)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29BanNrSWNnSTV3TitIT2E1V1ZKdXRzRFA2MDdsUEwrNHpkYW0rc0JWSDVk?=
 =?utf-8?B?a3lreFhjVlNlVUhPQXZBUmZRaHBId3lMWUpNRG1VS1VKcGdpSXE3MVkxZldP?=
 =?utf-8?B?WTd3TVY4SDEvUlRoa0Q2aE5xaVdoT0IzY1FFQWlrM3U5ZklDOGF1YTFWKzlp?=
 =?utf-8?B?RTBwK3FGR25IeHhObzdCT0NjMWpjejFZVDAzNTNWenJGT2hpTUY4Z2Q4WnRv?=
 =?utf-8?B?YUFkQkVuenl0V0dURFFQNDR6VjJhUjJEQk93cHU1WWRwWElSOGNlYUVheDdL?=
 =?utf-8?B?eDlpb1R0enpCZ0VRYkpvMFBZcElKL1Y1ZGdLdUplaVoya2NobFJjTVBYSGN3?=
 =?utf-8?B?MDhmQXl0RUlweVdVTlNVTjQ5U2RKbFQraFQwNllneWowd055L3FHT3ZrQXpu?=
 =?utf-8?B?bXkxMEtCSGtDc25tNTV2cUpDVGp6Zk1va0Y5bDBzSFRYOC80ZGVzR2J4TzRM?=
 =?utf-8?B?WUtVM0N1TjRWWEhBUEQ1ZW5veFlDNzFRMnBhTEhaTWtNallKRWhnYkNWWE1o?=
 =?utf-8?B?ODFzU0t1SDBNUERMV1dLT1VxY3hwMDRrdzB5dnNuNWR0NWRzRnhGR3pWRit5?=
 =?utf-8?B?YkhXL2J6YTYwc1hPVFNqRkI0T3ZMbis0dUdhUmNvQkhmR0RYQ080Vjh4ekZN?=
 =?utf-8?B?SFcyNlkwT0JiV2hpZ2lsMGNncFZPTHA1cUNVWnlHTHZJeURWZ29BVDMvS2tM?=
 =?utf-8?B?UUUzdUtVYklUditPbTZxaWM4R0hUNExlZmhPNjdhT3BkYUJWdWMveWdJUWVp?=
 =?utf-8?B?dnNZZnRyOW54b2d3NWdNdUFicEx2bUtSemprZmlYQmswV2YwcjhxdTh6dVJ3?=
 =?utf-8?B?YjcwdEtQWitFU1drN0RCWitnY1hjeCt3M3pGWDhRNjF1VCt6SVY3TkV0Y05r?=
 =?utf-8?B?UnYrOC9wQTZIUEExOEV5U2tMSjI0ektnanhhQXM5TVZ3clh4WjVJRGVJRTJ1?=
 =?utf-8?B?S2dhMXZlS3hRZGVoWEwyUTlBSWVrMTNwMlFrZ2RoZnAvWThnM2lhV1pCSTl2?=
 =?utf-8?B?TzNOVDNiTlZRZkw0QjZKRDNGNjQ5am1YaXNDdEV4RW1PY1dIQ1N5UVNrRFJ6?=
 =?utf-8?B?VnJadWhEak93dmU2SnpUT2hwdDcvdmhzUzFjdUQ1cGZISTVYSWxBZi9YdWhT?=
 =?utf-8?B?dlR4YXlkT0JpUkd3Y0VUSUdJTk85cDFEWkVXQmgyQk16WGRKeDRxa3FONG1r?=
 =?utf-8?B?MlpMcFE5T1J2L09BNGhXT09DbFZqenBFQ1ZKcE5Lem5YV2xWY2xndTdsWWxk?=
 =?utf-8?B?UGFHdVR2T3pPOVNzUmtXTVRTNnhBS0Z2SnZLaWRNb25EdnpyeW14cFNNMzhB?=
 =?utf-8?B?QmpMTTk2YVVCc1RHNFRMNHRYa1dOdUpPbGZTM3BVT05KNlVERDFWVkRKVFI2?=
 =?utf-8?B?WXZwUmtMcTY1VEJDc3RpZ29NbzhQWjNOcklXVUNsS1RvVzVvZHlGb2NUa1Jy?=
 =?utf-8?B?QTh2Ykttd1VhYm1zeHIweEhibWdHazgvWFBieXFQME5VQm1SRFRYZVR4bGx4?=
 =?utf-8?B?bDNWUHVESERyR0xQOG95anBCZ3pvTXk3MG12OXJESDhSb29oU2xKMUlodjR1?=
 =?utf-8?B?MnZvMHlsNG94VGFoNGQ3NkttME5mdy9aZHlPUk93NjhoUm9xU3NLU3dFN2Nm?=
 =?utf-8?B?cDNYRUpJSTVxU0dGRFBzS3hPeTcyWndtWW9zVGdiVlIrbWUzRjdGTE13L29X?=
 =?utf-8?B?OTFJRTZZVU9oNldRbXdXQW1VdTIxakh3R3BNbStDRnE4OFMxL2xaNEljNnNH?=
 =?utf-8?B?anRNN29QNDNMQVJXNmJpbXJaSm4veFUxVW1JU1NrWWJqV0ViVFphQy9ITnhi?=
 =?utf-8?B?dXdiUFY1TWNqb3FjbzVHSG5tY2NkUVZTZ3V0MlJvV1daQnVwVkFEbjc5VXYr?=
 =?utf-8?B?NTc2UXpVeUh4U2hpdWp0V2NWN3RUbUZrUWZFRTZLZ214Z2lpSnhtQ2J6TElx?=
 =?utf-8?B?T0lpcE5iVXMrMU5VTDc1N1c0dGdrYklTM0F4RTZVWXh5bm1MSExiTXNjM1p3?=
 =?utf-8?B?Q0xRN0RDM1draVRQZUtaTWQ0Vlp0M2hUdlBqT2ovNkRYVUh0cHkzZXhMZXZi?=
 =?utf-8?B?Nkg5b2RZY3d4QnRJYk0yTFhEMGhncTRYMjhMUkdNV0pPNzlrWHExRkw1YkdZ?=
 =?utf-8?Q?IEHBJVufIh11wedwnCGOeysgl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f54c26-760e-4960-4d92-08db1b01be8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:37:30.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N83BXAyVr8bNJn3FGYzh6QJexiWMW0ZphlJO1PGGWyvvDUIrwvSj9/QbxmgASsnH6G+z9V0FG2Y+Dyk0A0v+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMiwgMjAyMyA5OjAwIEFNDQo+IA0KPiBAQCAtNDY3NSw2ICs0Njc5
LDMzIEBAIHN0YXRpYyB2b2lkDQo+IGludGVsX2lvbW11X3JlbW92ZV9kZXZfcGFzaWQoc3RydWN0
IGRldmljZSAqZGV2LCBpb2FzaWRfdCBwYXNpZCkNCj4gIAlpbnRlbF9wYXNpZF90ZWFyX2Rvd25f
ZW50cnkoaW9tbXUsIGRldiwgcGFzaWQsIGZhbHNlKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50
IGludGVsX2lvbW11X3NldF9kZXZfcGFzaWQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0K
PiArCQkJCSAgIHN0cnVjdCBkZXZpY2UgKmRldiwgaW9hc2lkX3QgcGFzaWQpDQo+ICt7DQo+ICsJ
c3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2X2dldChkZXYp
Ow0KPiArCXN0cnVjdCBkbWFyX2RvbWFpbiAqZG1hcl9kb21haW4gPSB0b19kbWFyX2RvbWFpbihk
b21haW4pOw0KPiArCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUgPSBpbmZvLT5pb21tdTsNCj4g
KwlpbnQgcmV0ID0gMDsNCj4gKw0KPiArCWlmICghc21fc3VwcG9ydGVkKGlvbW11KSB8fCAhaW5m
bykNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlpZiAoV0FSTl9PTihwYXNpZCA9PSBQ
QVNJRF9SSUQyUEFTSUQpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWlmIChod19w
YXNzX3Rocm91Z2ggJiYgZG9tYWluX3R5cGVfaXNfc2koZG1hcl9kb21haW4pKQ0KPiArCQlyZXQg
PSBpbnRlbF9wYXNpZF9zZXR1cF9wYXNzX3Rocm91Z2goaW9tbXUsIGRtYXJfZG9tYWluLA0KPiAr
CQkJCQkJICAgICBkZXYsIHBhc2lkKTsNCj4gKwllbHNlIGlmIChkbWFyX2RvbWFpbi0+dXNlX2Zp
cnN0X2xldmVsKQ0KPiArCQlyZXQgPSBkb21haW5fc2V0dXBfZmlyc3RfbGV2ZWwoaW9tbXUsIGRt
YXJfZG9tYWluLA0KPiArCQkJCQkgICAgICAgZGV2LCBwYXNpZCk7DQo+ICsJZWxzZQ0KPiArCQly
ZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUsIGRtYXJfZG9tYWluLA0K
PiArCQkJCQkJICAgICBkZXYsIHBhc2lkKTsNCj4gKw0KDQpjaGVjayB3aGV0aGVyIHBhc2lkIGNh
cGFiaWxpdHkgaGFzIGJlZW4gZW5hYmxlZCBvbiB0aGlzIGRldmljZS4NCg0KaXQncyB1bmxpa2Ug
U1ZBIHdoaWNoIGhhcyBzZXBhcmF0ZSBjYXBhYmlsaXR5IHRvIHRlbGwuDQo=
