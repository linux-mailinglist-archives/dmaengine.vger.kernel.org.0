Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29C56F1475
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjD1Jqb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbjD1Jqa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 05:46:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D2444A2;
        Fri, 28 Apr 2023 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682675189; x=1714211189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UBLMKTxruvUZKlmhFeN+WpJ4Cwgn21vZ62srrtFs2xc=;
  b=WxZHPPSNLHYK3h74xbCwWOmn/Sz2puziiyqdnTyzW8SHWfW/Q9uHUvhp
   e736TsBr/Po31nlxatXZYdGAZYbSrZ1SfODgfrOYFWXvejFDbcJjY1GbQ
   h9cFSTOxtkEEaBaln0HpOfAGAsudBJpVJfdIqP2b8db87STxbWNIPG+LI
   nsuM9oJi11+oL4kp2ZodV4KmQQeOk5cVC0VKwA0JUHP5WB+ISklnpwNqM
   5T1hIFBxOIRXeeyOpdpm5tsYnsq9xYYDKKFHPoaYNLDQxdMnrMgEKUNlS
   I4BOVWOoiwlqdVvMb2Q44gjsreZxohGO8BOCBdSjB01I+GsxhwK7gok4A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="332014970"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="332014970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="672113668"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="672113668"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2023 02:46:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:46:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 02:46:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 02:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ9x4vujZgaiH++UecM9vBLfsMjcPG2yfiA8n/Lq8MRpiuYpsaNY6CrOkndIQCWA0QggQZ8C43XqqATS9GzynTOOdHbnHL+sEsrxDf5AZlG6agTwhQK+b/5P+CT8fHstf2l8etX3+9AQrkJgo2vuhLTEH1UuB/NdbxqFgG4eQjh++aSAY5fDUMqWLrDGVFzfcz+uh93J6luNk4OXxtCHFJ++RWAaIlQ6rrrJR/rDfLdwzQmOHGifEawSgf24kGiaWb1oEf7VFG0cd2gmKFq4YexRwtOwcurgANU0lfhl0dPMeAQfLmsv27KeKUTcuxN9ZuK1877ndKdEYiBmoz4OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBLMKTxruvUZKlmhFeN+WpJ4Cwgn21vZ62srrtFs2xc=;
 b=WNQcLq4bdba/rAYSuLPIr8JD864gKDO5Ha/tCC+NcQy04m5NCY10a1WZa0BieboaYjnhY6KnWGOFKNQnvzQ3/Ss4BTZW0pldVZMU4kwzBpv8PsCJNYyjrTC+Hp/uk3YZxRunME9mhCTwzOEK0B0H1OpRTjZSFXxnMx67P3RT/2enFL4tye/rlfe5j7vTlx61XKnto5BoqEVsv7ZwkveDdbJRLe4CtvXrTNZ2RRIinysYBBGz9PYiVUgWjcjUP9PFhYXDa9zPQQwQTCcb+J/dEGhKVsb5BstOwL3817GdjEKGw3NgjjGLDF7ABDG77YsLpjYhi2eHNEHcq8dRFLArcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 09:46:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:46:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: RE: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Thread-Topic: [PATCH v5 3/7] iommu: Move global PASID allocation from SVA to
 core
Thread-Index: AQHZeTAViMSyyEOpO0G+LQmYevf5I69AeIDQ
Date:   Fri, 28 Apr 2023 09:46:25 +0000
Message-ID: <BN9PR11MB5276C41CCCCF3FDEA7DDF7AC8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230427174937.471668-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: c42cad7a-a9a4-49b9-96ab-08db47cd6f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqXxBlyAhBhpJB3dJmypdjhch5lLQIa+CCTWBmPkLk6ifrVSkEkeP7tNJIoEUGsD7mHCm/P3zbUOBacZqjLqQLlt1rQcU4XlH/1CsyV0Ra7JKiC0nF8ZXN15UPYOK7bil6QRlIG4TbnOgwFwUXRKsvlQrnqdojwts6QW2HaDGh6Pyv7BOCOaG//DzLuuaRf+N/gNXS9s/C88+j4kEcTTbCxUOGqJBId1IfMitoA4d2uhHFWcEycl0AHn8DCKnf9fvcQALvBRmKjl3GoAufv39ZWFM6Efm5/Kgdqot1k3vuPPdTNmLJjAIyiadSAw4kRtfCvhLiZFjaEL4/wEDNLpMPAxoXEN+f8Np89AMaPnAf9Vg/RdQSnB8a7F/fVBlue1sq0Icl5oXWvsQ1GsBqFKUFL8AbNjYbhCoDdyoMe/FYjvR/PBPcEHd2/QtJIE8im6y8FUr7sRsyGkDDM0QvicQmXm279TCr3qOKM/d8YY6HXFdgtebPKGclbYzhPPST+QhnTvRRYcDu4zh/TJ3Lgee0sEKWxWGWZk/Qd4JiJ9mR0NOMKl3yWQ8jdwQsNccO+Bs26HXVuvbjqpCFtGL5S7oeO9nRoccHclpPx+0QNxLUV5wp7TgN+xz27SNLEv3o/S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(86362001)(7416002)(41300700001)(26005)(9686003)(6506007)(2906002)(55016003)(52536014)(5660300002)(8676002)(8936002)(38070700005)(122000001)(33656002)(83380400001)(478600001)(38100700002)(7696005)(54906003)(186003)(110136005)(71200400001)(82960400001)(66556008)(66476007)(66446008)(64756008)(4326008)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5PaXd5RGVyTit1ek9qWUF5Z09PZTV3VVVva0UreHZFdGNWUk1sc24rVTNy?=
 =?utf-8?B?WTdFYXZyK1p0UVpYWC9jQmo5RE0yRXVKaHJ6dUhlVUFKTXJEQUZQeURyaVc0?=
 =?utf-8?B?YWtXTXBYNkl3a1o2Y1MwTUtObkg5OC9aZjJwZ2xuNm5EMGl0N3o2aENwOEd5?=
 =?utf-8?B?ek1QZTd6L1NJUHU3blB6dittVVdBQ3lsUUd3SUV5YWk1aVhvdk9PcTQ3UUpn?=
 =?utf-8?B?UTFlT2dSbzBSZWpUcVhGWk5Vb0dDNGozZjE3NmpNbkFBVEV5eDRwZ3N3QWto?=
 =?utf-8?B?MnZzazhLbjRDaTRQdkFIQTNLVXk0QktSbkxERDJRUFZOdmJZWFFDcWkwR0Ra?=
 =?utf-8?B?TEk0OEtqWU5HY25XM2VkVEg0SXNxb3gwREcvdkh1ZlZoTlhrc0pYRWxQUkY3?=
 =?utf-8?B?VFMvTEU5b01BWEZYaDEyMXpDNm1PR01jbkRERU93U05RQ3haa29FQ1IzZitL?=
 =?utf-8?B?VU1VY3ozWTdpU3NSZGpOczVsb0hjeTVFQ08yakFvTzI1dXBMSUNvWDhXazMw?=
 =?utf-8?B?cXpuSmZNUXR3VEpGenpKczFMcGh4OThTcml1VXpRcVRsUHlqUkdWcHNmWGx0?=
 =?utf-8?B?UElBMTJON0ZMYXBHbDhGVGJ6QXlJTG8xcVJoOFgxRHJOZHQ4UVI5eDVFOGhR?=
 =?utf-8?B?VzhMQ3JrNG5EK2hjOFhZZ3ZiZGJJUGVMU3JVK1dvSE8xQUF4Q1hGcFZyM2U2?=
 =?utf-8?B?ZXF6YWlZcDlFS2FsRnFHMTFZZHRLOXMwMUI1RTk2TTNXamRLR1J2TW1RL3d3?=
 =?utf-8?B?OTdnckV5ZWxwSmMySldvbURicXBBL0gzeTdNOWpxR1BwNDByYjB2V3pjTkVU?=
 =?utf-8?B?Sm91YWs2VVVIZzJyUmF4c1BJaFRNTXdJY3Q5Yk5UV1hDUDZydEpVeU5Dcncx?=
 =?utf-8?B?d3hkeXZsR29ZNFk4bVJtbFdhQjFCdGJmK1MrSEpwQUNBK2FwSjVWSkdRTjFW?=
 =?utf-8?B?NjYvMURKaWJkbi9aRUVrVmU2QTMyYVpVWk0rWW96TGZkZktDZjFrSTBwb3lt?=
 =?utf-8?B?SittZkQzUHNXSlVXMm9PeG1QSDBkWWg0U2pYazhlVGFDRWdERjlXakFLTGp4?=
 =?utf-8?B?QmNiSHVrREVaWGNPeTM5TEs0Yjg1REplakZuWEtMaGhoS3ljcUNJNjdXSDA5?=
 =?utf-8?B?b1ZVQmRWM3JlMHlRNzIyejRtMTFScHlrVm5jNnh2SHVBVUEvNjk2L0NQbXc5?=
 =?utf-8?B?VENxQU1hNSthc3RIMGNTQmdLVkY1M3FQM2haRTI1QWN5eEhnMnFwendVamMy?=
 =?utf-8?B?cm9YK282MmJrWU1QRHY1WHZqV1JTZUQvdENVbXZOcHBBZUxmNTFWREdGYmgy?=
 =?utf-8?B?Y0dXOHdXMkx6QjJWTnV4YTVYend6WXlQSjZ6TkhPWmcrMDRMYmFJYVc5eDVE?=
 =?utf-8?B?QnJQeXdhRzZnMVY2L29XVTRRcXY5a2YyMGNBVjY1bGI0SU44Vk1NWnIxQjhK?=
 =?utf-8?B?Q2kwWGs3UXlVWUIzbDhWdzBTSUVpdURmbnB0ck9oeUlKeFpoT09sb25VVllw?=
 =?utf-8?B?OEp0S2FFbVdsUFAyZkwvM2JhdDNtTEdNQlFGaWF3cDdQVXpjSWVmMVdEVEY3?=
 =?utf-8?B?MjVWenV1VXErL01Sb2hjOWdpNVgvdHMzeXpKZkJFZlhRZGVRWVVPWVVSZU5K?=
 =?utf-8?B?NHg4Rmc5WUhCSjFXcFYwYnJYT1RwaUoycU85a0h3TmtJTWFXNFFnQS9hZU1k?=
 =?utf-8?B?RktUcFhCelRaMk9lZTZQQVArK1RWcHJEUVQ0b1d4cVZkdmlRY001d0Q0dnZR?=
 =?utf-8?B?ME5rMlY0RUxwb3VoQ3lGOE9GYXdVZmVSaDE3R1ZTVkI0dCtwenJncVZOSWxU?=
 =?utf-8?B?NXNZa0Jud1YvNHI0RkZpRHpiaHNIRVZtRmoxNGxBK2NSc2UwYitndnU2Znov?=
 =?utf-8?B?RndOSXk2Z2d6djlZU1c3aVdhTk82VXNDSEs0ZTlGa3pYWGVNNjlXdWI2M1hh?=
 =?utf-8?B?Q0pYenErR241d0VRUzRYdjZDRDlheUhMTkNaOC9saXppTEFQUkpOVkFZNGdK?=
 =?utf-8?B?Y05qTmVnNnByUVd4YXc5a1pZWlR1Nzd1bkcwMHRyY2FsNlUvQXNocEw3bmtH?=
 =?utf-8?B?bmljYWRkVjdLSVVTVEt5a1RFQUxvYXhyZExuT0tMYXhhT1RwQVM5TitOOS9m?=
 =?utf-8?Q?795kWvfyi0WpyeLj1NgbRcKnS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42cad7a-a9a4-49b9-96ab-08db47cd6f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 09:46:25.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x46/nbHirp3+EnN4nQsP4coHJbfnMzz4yCNlZu74nTZ9WY8SvgBom4dAQ8Oy00ERojUyg9yYiSivCT4biX8UeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBGcmlkYXksIEFwcmlsIDI4LCAyMDIzIDE6NTAgQU0NCj4gDQo+IERldmljZXMgdGhhdCB1c2Ug
SW50ZWwgRU5RQ01EIHRvIHN1Ym1pdCB3b3JrIG11c3QgdXNlIGdsb2JhbCBQQVNJRHMgaW4NCj4g
dGhhdCB0aGUgUEFTSUQgYXJlIHN0b3JlZCBpbiBhIHBlciBDUFUgTVNSLiBXaGVuIHN1Y2ggZGV2
aWNlIG5lZWQgdG8NCj4gc3VibWl0IHdvcmsgZm9yIGluLWtlcm5lbCBETUEgd2l0aCBQQVNJRCwg
aXQgbXVzdCBhbGxvY2F0ZSBQQVNJRHMgZnJvbQ0KPiB0aGUgc2FtZSBnbG9iYWwgbnVtYmVyIHNw
YWNlIHRvIGF2b2lkIGNvbmZsaWN0Lg0KDQp3ZWxsIHRoZSBkZXZpY2UgaXRzZWxmIGNhbm5vdCBz
dWJtaXQgd29yayB0byBpdHNlbGYuIEl0J3Mgc29mdHdhcmUgdG8NCnN1Ym1pdCB3b3JrIHRvIHRo
ZSBkZXZpY2UuIPCfmIoNCg0KPiAgLyogQWxsb2NhdGUgYSBQQVNJRCBmb3IgdGhlIG1tIHdpdGhp
biByYW5nZSAoaW5jbHVzaXZlKSAqLw0KPiAtc3RhdGljIGludCBpb21tdV9zdmFfYWxsb2NfcGFz
aWQoc3RydWN0IG1tX3N0cnVjdCAqbW0sIGlvYXNpZF90IG1pbiwNCj4gaW9hc2lkX3QgbWF4KQ0K
PiArc3RhdGljIGludCBpb21tdV9zdmFfYWxsb2NfcGFzaWQoc3RydWN0IG1tX3N0cnVjdCAqbW0s
IHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gDQo+IC0JaWYg
KCFwYXNpZF92YWxpZChtaW4pIHx8ICFwYXNpZF92YWxpZChtYXgpIHx8DQo+IC0JICAgIG1pbiA9
PSAwIHx8IG1heCA8IG1pbikNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gIAltdXRleF9s
b2NrKCZpb21tdV9zdmFfbG9jayk7DQo+ICAJLyogSXMgYSBQQVNJRCBhbHJlYWR5IGFzc29jaWF0
ZWQgd2l0aCB0aGlzIG1tPyAqLw0KPiAtCWlmIChwYXNpZF92YWxpZChtbS0+cGFzaWQpKSB7DQo+
IC0JCWlmIChtbS0+cGFzaWQgPCBtaW4gfHwgbW0tPnBhc2lkID4gbWF4KQ0KPiAtCQkJcmV0ID0g
LUVPVkVSRkxPVzsNCj4gKwlpZiAocGFzaWRfdmFsaWQobW0tPnBhc2lkKSkNCj4gIAkJZ290byBv
dXQ7DQoNCmVtbW0gaGVyZSB5b3Ugc3RpbGwgd2FudCB0byBjaGVjayB3aGV0aGVyIG1tLT5wYXNp
ZCBleGNlZWRzDQp0aGUgbWF4IHBhc2lkIHdpZHRoIG9mIHRoZSBib3VuZCBkZXZpY2UuDQoNCg==
