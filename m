Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3F7B76EF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 05:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJDDrj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 23:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJDDri (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 23:47:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7766FA7;
        Tue,  3 Oct 2023 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696391254; x=1727927254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85YOkRJmW5aTWydQnRYmVQPvL7B27Vicia++vl/NZc8=;
  b=uGO1iVg5PExmMTz0zgzSkJZCs7/q8ttzna4RsdPQELWZP95mMAq03FI8
   1iBeShGJfLM9n7tW+plS9o3pip63zUjdKVdGwRbQjyJTbx3/eYSB1dYZS
   q1ZxJSJvvFObNsgFhWxaUn9Ot8VXJTSFZdaNzl4tPsiYjkujyEA3NSzaA
   2kGWEG+sXe2m9jBAX2fMj50eZZM16zVi1CI5yFCoiX9UV6ThvSa7lL7X8
   mLA3aGEhstkCQfE7tlwuTzLr0EbvgS2nWKqvzBwFwXBBBakr8SbycYvfB
   Gsv6t8wp+dVVRcB5bHBSvGyhoZ3w7k/KWg11ffc7t2v4pE9Yez1JbygN3
   A==;
X-CSE-ConnectionGUID: 7H469gUmSGCXZdgy/qs//w==
X-CSE-MsgGUID: W6hQQwtcQrKEZl7BGnrLdQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="7992578"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2023 20:47:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 3 Oct 2023 20:47:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 3 Oct 2023 20:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl+IokdOGqvv5AI/jS3QvndOvw7C8HloER9izpMkJs2j1cpi3CVMwK1kirQ1mBsFM2Mx9ebSHeLP5uq2jhM7sAPznwxfsul8tTTgraYbpqvGkqJAfBDVS0q6N7PsgH/F/DO/lawPc6QJ/CQaBx2VKgA3j4rOL/7NhG2HMsnSY7jfQkKbihV5AQ9oWIw6u4U/RfcgNyv5M45K6Vc4gMxyL2X5jEk9M9FCoG1QM7ix2kOV29UaynhCvQ1N2t1tPL+1MH1W7ORSf72ke4TNhWzYHZ9qtFvNrn5p5wBqp7PlUoqmxPJ+7PHaWMvJYh9WBoOAd5EmoeCiHnyDD4eDRt8Rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85YOkRJmW5aTWydQnRYmVQPvL7B27Vicia++vl/NZc8=;
 b=lt6yq4KJ5+DbIfRWMltQ5AKrvTM6X/3+VCWHWezZDO5THmhd+qGgAQDHuwMyyZqrbX9+bywDXXktTjD/oX7dFfH37RxoXgq30tvFmXz6UI9Fsh0QcYZlEMlY/pQn8iltcbMgFQzfoq9q+4Yl2Xen/T0NYQlK5GiQ/vP43+zEL4T797Nffd+SZs22kKUxbX2PXGtFj+cooV9aWb2JQwXFRGu3wnVSeGeI/gm2KP+7TB+FNXGH7vCTv6K91FRw058O3BjYVAFm+qk7JF168A8JaN8tb051hQDLie1DpKDCzYHyJarrjeePmw+IyV0qOjl8U9nkm2IQyu8xjnbWnoJ0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85YOkRJmW5aTWydQnRYmVQPvL7B27Vicia++vl/NZc8=;
 b=iglkWblOuD+EThkAa5A4sTtvTuTUwCuDc7pApqA/JY7SkI3R2I/Su3Uqzw+irO9OqrS4NE5WvS64zqmmJj2aLz/iFJDbhq1mpCyQ4Dx71TpW3kEuzWyZuHhc+bBXqErJt0ylVwvE9I3VD7BzmKrtFLpTsBQtf7SzQIMMs5PdoW0=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CH0PR11MB5442.namprd11.prod.outlook.com (2603:10b6:610:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 03:47:08 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 03:47:08 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <emil.renner.berthing@canonical.com>, <green.wan@sifive.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>
Subject: RE: [PATCH v2 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Topic: [PATCH v2 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Thread-Index: AQHZ9bEfSrhEFWigFU+chaZTfsHpRbA3rOQAgAFRb1A=
Date:   Wed, 4 Oct 2023 03:47:08 +0000
Message-ID: <PH0PR11MB56114DC76037F8C882D4CCF781CBA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-4-shravan.chippa@microchip.com>
 <CAJM55Z8+UtVwFRxOKPcNKmitzkZQ9tyecG46dhTZqiYZgw903Q@mail.gmail.com>
In-Reply-To: <CAJM55Z8+UtVwFRxOKPcNKmitzkZQ9tyecG46dhTZqiYZgw903Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|CH0PR11MB5442:EE_
x-ms-office365-filtering-correlation-id: ff0c1a18-d7c5-480a-2f35-08dbc48c957b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/byRisyHj4vhRaLBDpM+Fg7AlU9VEqf3GCCwP6QLagLI/jqzBwayjx8/pqbHghFtjlsGhhOz1X2g/Um5TCIvKhH8+isfkbC8R1q+KXUjwyqgwynylBLR7Lpm1iYX3nbYRn41bQb3/YF0AfKD1ZN++Ige7twxJNk/20enM0C5DSwws67Q36MrPKzWUoVxqW6euHUBvVJb5Ewp0SXbnropq9LNj7rHpMDwusakF6Z10CNlvnb15BO81QmNBlmdYh589uAjXVcNy66n4xQaCQgBrWd1f068/Fivl37KkddojEC+gXqG/P7/j9C2D1HYNggpzIw5UPjCvQnMAWm0PhVu2cpgGmPlhXVs/8tmvEDyIK5Bu8fFuJZ9/msD7gXLIGxSdy0RA98tudruB9xsRldWekWsYCiwIuuBwh7yROjbgh+sG56x3Nbkr9xYVBaUQMkIgmvUSWGgeXzfOMfW0k4sDMjzWZpQ52uGwJnoS1UtXQJJNKj5R/KmiVcMjvQ4AHPmk5GO/jYkebwlXW8uBtj79EyGUlMhWMDtfI7tP+TfDe77vGqAKh1K6jIkJtzYmvksZTGuUGH3a12Qw2XUye/1fPq4vxzFovjwc/KjGIUjm4+7ENv9zeP0Rt2F1Gcp160
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(2906002)(7416002)(52536014)(5660300002)(107886003)(8676002)(26005)(8936002)(76116006)(41300700001)(64756008)(316002)(66476007)(66946007)(66556008)(66446008)(54906003)(966005)(9686003)(4326008)(110136005)(6506007)(478600001)(71200400001)(83380400001)(122000001)(7696005)(53546011)(86362001)(33656002)(55236004)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZXMHNxREFoVlJ2NTNCZTJZY3NkZmVRQzl1MmtyTzhBcitxcmc0RDdwVWtB?=
 =?utf-8?B?THg3WWtGMzhTM2gvbXE4d0h0TkdlWXRrNG1na1JxOUExdHc5NjhTTDVWajBV?=
 =?utf-8?B?OEVYYkVuK1hYamg1enVGSGFXYnM3QkNOT2EydmRNUDJDY0NIK0xEMEEvL2hr?=
 =?utf-8?B?NDJFYXd3SFFOUHBabytMMXFDRmxUbWlmbmd1alJ6MTd6NHdPSEg4dDJhSGtE?=
 =?utf-8?B?MDY3R3RRdWFDUHBnOTRHV0xUQUtUU21NWVVLaHAvTmVJeDdSUHMwVUVVdU5h?=
 =?utf-8?B?SlBEV0c3ZDZYbFgwS0lzemF5STF5blY2WlZhMGJnWkFNRU1ESDN2NHRUNTFI?=
 =?utf-8?B?UGNJdTlIc1YxYU51VFM1aUsvSXB1bFFIZEo4Q2ZjSUZBcTk1RU1ZNVNvTnVw?=
 =?utf-8?B?QnQ5dUF6TG5vMTJtZUFZS2VySWJGa2Z4bVlBSDVnZytCZFdRN0pSL2VWZjh6?=
 =?utf-8?B?VFlzKzg3TVJjVDFvdHlEOEsvT2ZUVEVlc3VKTFcvdllaTGRHbzhSZCtCVCtI?=
 =?utf-8?B?bTRJdDlwWkJaaDBsZXFPRy90bzhuZVFUZEpKMFk2M2tVS2ZZMmFkYi9UcXo3?=
 =?utf-8?B?ckEwMngrbGJiU3NhVHk3Z2RHeUplVlYzc3ppclFJWHdCa3JBZVJkZEsyU2th?=
 =?utf-8?B?c05nWGM4MUdvVEoxa2dkdk51c01sUFhnL3ZIcVJhRXRWbzFzbVpyWHVLS05P?=
 =?utf-8?B?anowTHhqTmI5cmU3RXdRanllUXZMbHRMYzlJQ29Hb3NlVDNIZXB4dlE4azRl?=
 =?utf-8?B?RzdYeTFTQ24ySnFGZklWUXMxNHdFeTdTVlFxbXJ6S1h1TXVwK3RDd1JuVGNj?=
 =?utf-8?B?UC96azd1a2JhZjFCdEh3bHV6aitEd0J0SlpFNHIxdy9jUzN1UzdTQ1FuQUVF?=
 =?utf-8?B?SmpESjdpb3NZS1krMEZuUDFBSlR2TzlybHN3eFUwdWV2SXpUdlBlSFAxVVJo?=
 =?utf-8?B?cks1ODVjMUJucWdjZGROZUJ2ODFsMWdYcC80R2sycEM2d0I1aXZ5WW91eWhi?=
 =?utf-8?B?Ly9FbEFJQVlXMm5nUkN5WUZrQUQxNk4wQTZMajNPeXY1d1lEc2E5UC8wb0Nm?=
 =?utf-8?B?cXdKMEdpeDR5NW9XWkZ6QVkxRzRwaXp6QXBzaW11ZUptKzRVRzU1c251MklD?=
 =?utf-8?B?VDVOT21GNkpTM1lhRlppcnNjbjZnRmNXVEl5N2g5U3p5b3E5VWZYbjdBZUor?=
 =?utf-8?B?c2xZc0NHaU9JcWhLaSs1RUtLeGhrblZJVnBxTEhRcTBOUUovNWpvVkV5c2pt?=
 =?utf-8?B?NjE0WXUwU1c4aW1RdHRucXJjUG1XM0Q1ZDdUWkJBL0t5bzRZb25ROFF4TDZt?=
 =?utf-8?B?bFl5NFlRM1dEc2tIUkwwNkdkQnQvdEVjV1ErYmJDU21KQkV4bGlpbUZLYXNj?=
 =?utf-8?B?OU5DSEZTMy93dkRtMmJwdW1meUN0bVNacnc1OGJNeUlua29DaEtiemoxQkY0?=
 =?utf-8?B?VUc2SXFiV3NSTnBibURORXI1SHMrYmcwUVZtTjdQOHJIbnVRRnZyNy9LZis5?=
 =?utf-8?B?WlRwZEptbE5kaFc5ZVl5aGZQYlFGbHJmT1FNTUpoZjB2bWxoRWNDcDlHVHFG?=
 =?utf-8?B?OVd5T2pObGpvd3p1OVJqWlR4WlhrZERYa3NMeFNUNHhoNTlreThDclRycHVF?=
 =?utf-8?B?Q2k1SDBZcXhwUDlIUUZjZFA5S0IwMzgzTUJNTzNvOC9YWUk4R0c2Nmd3SUpa?=
 =?utf-8?B?OXB1SzkrcVQ1MVpNTmNvKzdLOXZuWHdPUlk4OGVlak5WM3hUdzQrcW5hQk5E?=
 =?utf-8?B?aSt0NXEyRWNEQjlueFljcVRSVCsxeGY1SmVMVEFwOWVFQ3RyNC9pN3lmZE9p?=
 =?utf-8?B?cFozMWhNZkhMc2JGMXNVaS9xaUtQSmt4QjhKSU85di9WRVhMY0J4ZnZwTkNn?=
 =?utf-8?B?Ynhza3BBZlhRMTJGL2FqZWZucmRFL0NZQUg2RVFBeS9iRUZsbXRpSFNIZk9Y?=
 =?utf-8?B?THJBUlFLOXN0dUhmQ1VUSTN4VUxTQWJvVjRKc0dtWnBvQUhyM0Znb1JPQndG?=
 =?utf-8?B?MlUyc1ZJc0l4cWtabExHS0U5NWRmQVZpU3FFOWs1eEhUMThsbEEyNEFjTXlz?=
 =?utf-8?B?cXkyUURicStTUVhrRkl1ZFlwV29wWEUzcGhBRFhwclVtTWVzTVZDRVU5WHFP?=
 =?utf-8?B?cGRVMVppbUlSeXMxQUFnQmxNSXZ1YVFqU1RGVXB5dmF6dCtZL3ZSN0NFS2or?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0c1a18-d7c5-480a-2f35-08dbc48c957b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 03:47:08.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZl+GlfB4I7UnPCo0HL4UVdaNb+O1xlEnqsJC7WgEvvkVNjZA+aPso3kKJDoci/t/IlohkprRQhwj6nymTupFsvbzXrZ5a2GYcQkzX7EYgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgRW1pbCBSZW5uZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RW1pbCBSZW5uZXIgQmVydGhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMywgMjAyMyAxOjA1IFBNDQo+IFRvOiBzaHJhdmFu
IENoaXBwYSAtIEkzNTA4OCA8U2hyYXZhbi5DaGlwcGFAbWljcm9jaGlwLmNvbT47DQo+IGdyZWVu
LndhbkBzaWZpdmUuY29tOyB2a291bEBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+
IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgcGFsbWVyQGRhYmJlbHQuY29tOw0K
PiBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IGNvbm9yK2R0QGtlcm5lbC5vcmcNCj4gQ2M6IGRt
YWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgTmFnYXN1cmVzaCBSZWxsaSAtIEk2NzIwOA0KPiA8TmFnYXN1cmVzaC5SZWxsaUBtaWNy
b2NoaXAuY29tPjsgUHJhdmVlbiBLdW1hciAtIEkzMDcxOA0KPiA8UHJhdmVlbi5LdW1hckBtaWNy
b2NoaXAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNF0gZG1hZW5naW5lOiBzZi1w
ZG1hOiBhZGQgbXBmcy1wZG1hIGNvbXBhdGlibGUNCj4gbmFtZQ0KPiANCj4gW1lvdSBkb24ndCBv
ZnRlbiBnZXQgZW1haWwgZnJvbSBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tLiBM
ZWFybiB3aHkNCj4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRl
bnQgaXMgc2FmZQ0KPiANCj4gc2hyYXZhbiBjaGlwcGEgd3JvdGU6DQo+ID4gRnJvbTogU2hyYXZh
biBDaGlwcGEgPHNocmF2YW4uY2hpcHBhQG1pY3JvY2hpcC5jb20+DQo+ID4NCj4gPiBTaWZpdmUg
cGxhdGZvcm0gZG1hIGRvZXMgbm90IGFsbG93IG91dC1vZi1vcmRlciB0cmFuc2ZlcnMsIEFkZCBh
DQo+ID4gUG9sYXJGaXJlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlIGFuZCBjb2RlIHRvIHN1cHBv
cnQgZm9yIG91dC1vZi1vcmRlcg0KPiA+IGRtYSB0cmFuc2ZlcnMNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuYyB8IDI3ICsrKysrKysrKysr
KysrKysrKysrKysrKy0tLQ0KPiA+IGRyaXZlcnMvZG1hL3NmLXBkbWEvc2YtcGRtYS5oIHwgIDYg
KysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEu
Yw0KPiA+IGIvZHJpdmVycy9kbWEvc2YtcGRtYS9zZi1wZG1hLmMgaW5kZXggMDZhMDkxMmExMmEx
Li5hOWZmMzE5ZDRjYTMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9zZi1wZG1h
L3NmLXBkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL3NmLXBkbWEvc2YtcGRtYS5jDQo+ID4g
QEAgLTIxLDYgKzIxLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfZG1hLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAic2YtcGRtYS5oIg0KPiA+IEBAIC02Niw3ICs2
Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2ZfcGRtYV9kZXNjDQo+ID4gKnNmX3BkbWFfYWxsb2NfZGVz
YyhzdHJ1Y3Qgc2ZfcGRtYV9jaGFuICpjaGFuKSAgc3RhdGljIHZvaWQNCj4gc2ZfcGRtYV9maWxs
X2Rlc2Moc3RydWN0IHNmX3BkbWFfZGVzYyAqZGVzYywNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTY0IGRzdCwgdTY0IHNyYywgdTY0IHNpemUpICB7DQo+ID4gLSAgICAgZGVzYy0+
eGZlcl90eXBlID0gUERNQV9GVUxMX1NQRUVEOw0KPiA+ICsgICAgIGRlc2MtPnhmZXJfdHlwZSA9
ICBkZXNjLT5jaGFuLT5wZG1hLT50cmFuc2Zlcl90eXBlOw0KPiANCj4gVHdvIHNwYWNlcy4NCj4g
DQo+ID4gICAgICAgZGVzYy0+eGZlcl9zaXplID0gc2l6ZTsNCj4gPiAgICAgICBkZXNjLT5kc3Rf
YWRkciA9IGRzdDsNCj4gPiAgICAgICBkZXNjLT5zcmNfYWRkciA9IHNyYzsNCj4gPiBAQCAtNTIw
LDYgKzUyMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2NoYW4gKnNmX3BkbWFfb2ZfeGxhdGUoc3Ry
dWN0DQo+IG9mX3BoYW5kbGVfYXJncyAqZG1hX3NwZWMsDQo+ID4NCj4gPiAgc3RhdGljIGludCBz
Zl9wZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAr
ICAgICBjb25zdCBzdHJ1Y3Qgc2ZfcGRtYV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0KPiA+ICAg
ICAgIHN0cnVjdCBzZl9wZG1hICpwZG1hOw0KPiA+ICAgICAgIGludCByZXQsIG5fY2hhbnM7DQo+
ID4gICAgICAgY29uc3QgZW51bSBkbWFfc2xhdmVfYnVzd2lkdGggd2lkdGhzID0NCj4gPiBAQCAt
NTQ1LDYgKzU0NywxNCBAQCBzdGF0aWMgaW50IHNmX3BkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZQ0KPiAqcGRldikNCj4gPg0KPiA+ICAgICAgIHBkbWEtPm5fY2hhbnMgPSBuX2NoYW5z
Ow0KPiA+DQo+ID4gKyAgICAgcGRtYS0+dHJhbnNmZXJfdHlwZSA9IFBETUFfRlVMTF9TUEVFRDsN
Cj4gPiArDQo+ID4gKyAgICAgZGRhdGEgID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2
LT5kZXYpOw0KPiA+ICsgICAgIGlmIChkZGF0YSkgew0KPiA+ICsgICAgICAgICAgICAgaWYgKGRk
YXRhLT5xdWlya3MgJiBOT19TVFJJQ1RfT1JERVJJTkcpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHBkbWEtPnRyYW5zZmVyX3R5cGUgJj0gfihOT19TVFJJQ1RfT1JERVJJTkcpOw0KPiA+ICsg
ICAgIH0NCj4gPiArDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyAiU2lmaXZlIHBsYXRm
b3JtIGRtYSBkb2VzIG5vdCBhbGxvdyBvdXQtb2Ytb3JkZXINCj4gdHJhbnNmZXJzIiBzbyB5b3Ug
d2FudCBzdHJpY3Qgb3JkZXJpbmcgYnkgZGVmYXVsdCBhbmQgdGhlbiBhbGxvdw0KPiBvdXQtb2Yt
b3JkZXIgdHJhbnNmZXJzIGlmIHRoZSBtYXRjaCBkYXRhIGFsbG93cyBpdCwgcmlnaHQ/DQo+IA0K
PiBCdXQgaGVyZSBiaXQgMyBpcyBzZXQgYnkgZGVmYXVsdCBhbmQgY2xlYXJlZCBpZiB0aGUgcXVp
cmsgaXMgc2V0LCBzbyBpdCBsb29rcw0KPiBsaWtlIGJpdCAzIGFjdHVhbGx5IG1lYW5zICJzdHJp
Y3Qgb3JkZXJpbmciIGFuZCBub3QgIm5vIHN0cmljdCBvcmRlcmluZyIgYXMNCj4geW91J3ZlIG5h
bWVkIGl0Lg0KPiANCj4gVGhlIGNvbmZ1c2lvbiBoZXJlIHByb2JhYmx5IHN0ZW1zIHVzaW5nIHRo
ZSBzYW1lIGRlZmluZSBmb3IgdGhlIHF1aXJrIGFuZCB0aGUNCj4geGZlcl90eXBlLiBVbmxlc3Mg
SSdtIG1pc3Rha2VuIGFib3ZlIEknZCBmaW5kIHNvbWV0aGluZyBsaWtlIHRoaXMgYSBsb3QgZWFz
aWVyDQo+IHRvIHJlYWQ6DQo+IA0KPiBzZl9wZG1hLmg6DQo+ICNkZWZpbmUgUERNQV9GVUxMX1NQ
RUVEICAgICAgICAgMHhGRjAwMDAwMA0KPiAjZGVmaW5lIFBETUFfU1RSSUNUX09SREVSSU5HICAg
IEJJVCgzKQ0KPiANCj4gc2ZfcGRtYS5jOg0KPiAjZGVmaW5lIFBETUFfUVVJUktfTk9fU1RSSUNU
X09SREVSSU5HICAgQklUKDApDQo+IA0KPiBkbWEtPnRyYW5zZmVyX3R5cGUgPSBQRE1BX0ZVTExf
U1BFRUQgfCBQRE1BX1NUUklDVF9PUkRFUklORzsNCj4gLi4uDQo+IGlmIChkZGF0YS0+cXVpcmtz
ICYgUERNQV9RVUlSS19OT19TVFJJQ1RfT1JERVJJTkcpDQo+ICAgICAgICAgcGRtYS0+dHJhbnNm
ZXJfdHlwZSAmPSB+UERNQV9TVFJJQ1RfT1JERVJJTkc7DQo+IA0KDQpUaGFua3MgZm9yIHRoZSBp
bnB1dC4gVG8gYXZvaWQgY29uZnVzaW9uIG9uIHRoZSBuYW1pbmcgb2YgdGhlIG1hY3JvIGFuZCBu
ZXcgbWFjcm8gZm9yIHF1aXJrDQpJIHdpbGwgdHJ5IHRvIG1vZGlmeSBpdCBhcyB5b3UgbWVudGlv
bmVkLg0KDQpUaGFua3MsDQpTaHJhdmFuDQoNCj4gPiAgICAgICBwZG1hLT5tZW1iYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ICAgICAgIGlmIChJU19F
UlIocGRtYS0+bWVtYmFzZSkpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwZG1h
LT5tZW1iYXNlKTsNCj4gPiBAQCAtNjMyLDExICs2NDIsMjIgQEAgc3RhdGljIGludCBzZl9wZG1h
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgIHJldHVy
biAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzZl9wZG1hX2RyaXZl
cl9wbGF0ZGF0YSBtcGZzX3BkbWEgPSB7DQo+ID4gKyAgICAgLnF1aXJrcyA9IE5PX1NUUklDVF9P
UkRFUklORywNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIHNmX3BkbWFfZHRfaWRzW10gPSB7DQo+ID4gLSAgICAgeyAuY29tcGF0aWJsZSA9ICJz
aWZpdmUsZnU1NDAtYzAwMC1wZG1hIiB9LA0KPiA+IC0gICAgIHsgLmNvbXBhdGlibGUgPSAic2lm
aXZlLHBkbWEwIiB9LA0KPiA+ICsgICAgIHsNCj4gPiArICAgICAgICAgICAgIC5jb21wYXRpYmxl
ID0gInNpZml2ZSxmdTU0MC1jMDAwLXBkbWEiLA0KPiA+ICsgICAgIH0sIHsNCj4gPiArICAgICAg
ICAgICAgIC5jb21wYXRpYmxlID0gInNpZml2ZSxwZG1hMCIsDQo+ID4gKyAgICAgfSwgew0KPiA+
ICsgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtcGRtYSIsDQo+ID4g
KyAgICAgICAgICAgICAuZGF0YSAgICAgICA9ICZtcGZzX3BkbWEsDQo+ID4gKyAgICAgfSwNCj4g
PiAgICAgICB7fSwNCj4gPiAgfTsNCj4gPiArDQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IHNmX3BkbWFfZHRfaWRzKTsNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciBzZl9wZG1hX2RyaXZlciA9IHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvc2YtcGRt
YS9zZi1wZG1hLmggYi9kcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuaA0KPiA+IGluZGV4IDVj
Mzk4YTgzYjQ5MS4uM2IxNmRiNGRhYTBiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL3Nm
LXBkbWEvc2YtcGRtYS5oDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvc2YtcGRtYS9zZi1wZG1hLmgN
Cj4gPiBAQCAtNDksNiArNDksNyBAQA0KPiA+DQo+ID4gIC8qIFRyYW5zZmVyIFR5cGUgKi8NCj4g
PiAgI2RlZmluZSBQRE1BX0ZVTExfU1BFRUQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4RkYwMDAwMDgNCj4gPiArI2RlZmluZSBOT19TVFJJQ1RfT1JERVJJTkcgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCSVQoMykNCj4gPg0KPiA+ICAvKiBFcnJvciBSZWNvdmVyeSAq
Lw0KPiA+ICAjZGVmaW5lIE1BWF9SRVRSWSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDENCj4gPiBAQCAtMTEyLDggKzExMywxMyBAQCBzdHJ1Y3Qgc2ZfcGRtYSB7DQo+ID4gICAg
ICAgc3RydWN0IGRtYV9kZXZpY2UgICAgICAgZG1hX2RldjsNCj4gPiAgICAgICB2b2lkIF9faW9t
ZW0gICAgICAgICAgICAqbWVtYmFzZTsNCj4gPiAgICAgICB2b2lkIF9faW9tZW0gICAgICAgICAg
ICAqbWFwcGVkYmFzZTsNCj4gPiArICAgICB1MzIgICAgICAgICAgICAgICAgICAgICB0cmFuc2Zl
cl90eXBlOw0KPiA+ICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgIG5fY2hhbnM7DQo+ID4g
ICAgICAgc3RydWN0IHNmX3BkbWFfY2hhbiAgICAgY2hhbnNbXTsNCj4gPiAgfTsNCj4gPg0KPiA+
ICtzdHJ1Y3Qgc2ZfcGRtYV9kcml2ZXJfcGxhdGRhdGEgew0KPiA+ICsgICAgIHUzMiBxdWlya3M7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICAjZW5kaWYgLyogX1NGX1BETUFfSCAqLw0KPiA+IC0tDQo+
ID4gMi4zNC4xDQo=
