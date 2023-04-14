Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD866E2CB1
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDNXIn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Apr 2023 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNXIl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Apr 2023 19:08:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A84221;
        Fri, 14 Apr 2023 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681513715; x=1713049715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ui3mori7XIEZ6LTcjA8o6NXG/WpxH9UAus+5RZPdGTE=;
  b=QBpyDsSL0c/8vU444Mn1dnqDz0LSVEE18ia68m0g8fTuhzV96LwFkWwb
   GjKzhCuyJYL96Tc1wpafw+VUfbd5/St5DB9O6pqUYd4uE6qtmGI839EXI
   aq2g5/lS7Yb7Z0e6SKz2Aod+6X2K5vbcTb+BomFuM7h18ZGP1KlroRPjV
   dUoYIIG+hU0Cl34/Gc8XWDkx/QSCVVv9AEtB9FK/34Si29I9o6If8riJD
   gXfE1zPv7pyXyb0zD3JZ9lVGyPzIu6mZSMblBqDdjG7m8szZWct+ny6FN
   4nSZiScaXOKFew4UYfBvKmt54wp17LU4AQiI15NT0qyTNC0uaH/J2utSO
   w==;
X-IronPort-AV: E=Sophos;i="5.99,198,1677567600"; 
   d="scan'208";a="206607751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2023 16:08:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Apr 2023 16:08:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 14 Apr 2023 16:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfF63wlQxFqFyVRWdN+ya8nffYD8l6qtZKhLsmhiG8wg34W48JUaJ33Cgl5ktPc8fWNTJcetuQUHsGPm8v7vr38Hsu5Ls6Mln1B1CGvCHK7dTTDEnHOkC07AhdMKUIJTKru3KEAmJnvwyxsm1XK1YsmaF9gQB3zYuR3SSlwDn3RasCY/t/63qmondp/1QcIpzMS2rV2l3PWAnuh3NY1SdvBllMj9XxftBVEUIwgR4wDHGVul8wgiJyxKbyb3q4G5/r5NQMBcKYmV9hyecVxTHOqiF3Bj/L5zoqFCV2p1tQR41U9pv6zbKefHmfw7TUeJecCaZq8XTGborn1HgdL5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui3mori7XIEZ6LTcjA8o6NXG/WpxH9UAus+5RZPdGTE=;
 b=fUBSsQhv+gg00ZRvsO8F4Ww5rgJTmhHUC4Kg+bgizz2NrkfeWPgeu1FmA6t/tEhOre3Nct39vpI+v4n2os0fA2VHWxwPI3+gyjQo02R7ymlXHjy0rso4eAlSuT7oW96MTWibj55Y15Gtw91R/6N+BRGPOiMYgo41Ai4ugGt5M9aeDB8HXczD6xLbve6kSMbgf2K30zMERffPzZGFgpTSDvwcHNpXSrYk7WYJIdF9Cnu7Sr2anSRpyvNtOk/vrPzLVJSm0awLL9r6GNCVae8/EOAOBxWun3kFL2jFnXzETPYudsVnKsMZxvsVWkcI+CFCfygQq3q9k/CTGYf48MbHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui3mori7XIEZ6LTcjA8o6NXG/WpxH9UAus+5RZPdGTE=;
 b=SlEb3sau30+wZlrQCe4guTQr6weaFKF4v4Ih2plJzUU608AnibmzMOP2nctVkgX/IUfK70DzVIRpRSTAREYStAWzJ6KCvW9e0PjS+WQA+DaFhlLNQjOATmiwyd/ZANZe3HVIEzt0LXz7IeD3xG8Df5TDnrG3ULXqOQCHpBDMA2A=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.44; Fri, 14 Apr
 2023 23:08:16 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%6]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 23:08:16 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZZmFWCpgZadogBUKZpBFKgoENK68kyiyAgAUbAwCAAHf9gIABIgwA
Date:   Fri, 14 Apr 2023 23:08:16 +0000
Message-ID: <10fb478ddcf4d2589b9440e2b936f59b2ff27d5a.camel@microchip.com>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
         <20230403180630.4186061-2-kelvin.cao@microchip.com>
         <ZDQ8geSEauTsd2ME@infradead.org>
         <cee60331584b0408f61652376234078d4049359c.camel@microchip.com>
         <ZDjpjzj3xPaeeE1c@infradead.org>
In-Reply-To: <ZDjpjzj3xPaeeE1c@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|SA2PR11MB4987:EE_
x-ms-office365-filtering-correlation-id: eb6e3f83-eb8f-4c36-60b6-08db3d3d212b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KwW/SAijOSSZ5UUKclxQuV6NX0OEEeGAsp4d9Ht4Vd/KIUAMlPDvg+SCzVm0Z14KlHQZY0t2E1s02KlX1P22GCaty+s1DjzuhibkBZqi5jPkpFFyG7R4/COzDCLFnQx2N4MkLzvTq7Yt9L9htKI0VK15xDayaX/sxSnRYUi6yX8FCCG8YYmRiAzyRDFkiVn3YYF94RoOruoh6smo6fjkveUKvLS3l0U5SNV0VmG4kJkOEr3LfvuEkTt4ctYCOFQMaIi3aG0iqeF0m5uNolorkU22GrGnqp7IDgMty/ss2v6CG/HuWu+uuSxGEjzXlHJS9pc2k1REZwBLKgiz1gZlo602LQjQmMsYZtNgi9dQECIlwcJpzifMmfkAGRT7OXVRRX2zkdAX2eqodctgB+Rq6NyCreHVuFIg/KqHEC7p8OkQFEyrB/6xsptOvv2X2FCfyNJ4AvnoNjWGeiCCIWh6qYfUnhgR1728wsqGCtm85nLoKnGsAuKnrnCN16JfBeyyCCiPz2M4L7KmBgRX0VmZr4iZTizFg4+LfiM/iaUmsga1W/ixQRDe0ofUhe9gl4lcjiAkOwbwB+mTnsxj4PVowkOL2hnFbiM3BxSj6ib7ctwzHBAtpbkranFxUvC/Yq9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(6512007)(6506007)(186003)(26005)(91956017)(66556008)(66446008)(64756008)(38100700002)(122000001)(6486002)(71200400001)(83380400001)(2616005)(478600001)(66946007)(76116006)(66476007)(4326008)(6916009)(316002)(41300700001)(5660300002)(54906003)(2906002)(86362001)(38070700005)(36756003)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aloxZ0IxQ1Q1RlIwbC9OREVKS3lsZnIvenh4WHF5c0EyRndhY2xTbkxQenJX?=
 =?utf-8?B?WVZtd3lLZnQ1Ni9QQXZ6YzlkM0tMTy9BZVI1MzZxb3plREtRWlF0QytRMmNC?=
 =?utf-8?B?Zks2dTFUU1hYaHp4bWFjOUFhYUhYNnRDK3RSTjBzRVdpSWZpK2VoVGs3aTht?=
 =?utf-8?B?Z29MYURjQXEzQWlndWNvMlI2WHlmUnlKT1JVNnpUbFdwRDlpY1FwbTlYOTk3?=
 =?utf-8?B?UVlqeUFWdUpySUxsQkt2YXJBUnMvcDVjenBMTnhrQ0VoeVhOdmpEcWZtemVE?=
 =?utf-8?B?ZmZVc0ZnVmx5NkZPa3BWdmsrMlVKU3ZFbGJXT095T29RdjdaZENhalc0RllJ?=
 =?utf-8?B?aEg4Vmd5QUlFZ21IaGhlczV0L0hkT21xYVZQQlQxekZRRUs1TFJwRkF6ckFk?=
 =?utf-8?B?TjVrMFdNS2lUcmRFL3oyb2ZRL0FTZStUSU1LQlBEMHRNdUFKS1BJZHYzODdp?=
 =?utf-8?B?Rk43MzhncFBvTk9zNDI0QXBMTWdCc3N0cndaNTZ5WW1HbmVGYk9zRkRRNUl6?=
 =?utf-8?B?YmFFV214YWdPcG5jcGIxc0Z3VXdsOFhsaTJhZ1BYekgwd1R4ZUVSQ1M5Q2Ey?=
 =?utf-8?B?aDRGNFFGZFJYWXkzMDhJSGNlaitjUGJFVS9HYUo2N1FubFFYZlVSUTVYRGxY?=
 =?utf-8?B?SHFwUU91V2VCN2NPOXEvQ1lGVHpDL08raTBzL0kvMkZPS0ZvaDBwd3phYUhr?=
 =?utf-8?B?dmt6THNnOXZRZUMyL21LR1VSb3FTV0xGem5LdjB4azVzVlFUUndqSzVmNDkz?=
 =?utf-8?B?azRtdDV4Sy9KR0pNeVl3RmpHSURMQ0JyM3lJWndBRk9xTTc5S2xxMWxjamx1?=
 =?utf-8?B?RDhCOTZTZ21WS00xTWxFc251eUFKLzRLMVhmU01lYnVVTCtXUm52Z05mdERk?=
 =?utf-8?B?LzJJSEs0MUhEakdLemM1cmVVdmZGazgyNjZGV0h6YW4wWE42ODluenFBRytC?=
 =?utf-8?B?bVcva3M5WVlSczBxNGo0ZnlrYWZFc0o3WGhRSVlnUVRiMmE1UmR6TWNlb3c5?=
 =?utf-8?B?dXlyWUdQdlJoNGExTHZQUlNna3EwRi83QytxelJyRklnVHJCbHNNOG9RVzBM?=
 =?utf-8?B?STNZNmZPRjhkOW5qdGVpUGNlYXQwbk1FVTRLQ3dnekE5a21RS0UrdGo0VjNL?=
 =?utf-8?B?WlNrazJOWStURG8zclBvMTRxdmtEeFVSNGU3bng0U0FEMGhBMUdtaUVaS1dY?=
 =?utf-8?B?K2FvdU9nVGdwRlhOZkhCNVBLSFNQa2V2a2h0ZHNZaUFLTGJyNkxJVGVmM3Uz?=
 =?utf-8?B?VGF6TEVraGlOQmw3T3JDMGF5L3dXbXhrVUFFRDM2ZzNqcE1MdGR1ZmF3bUtC?=
 =?utf-8?B?VTdWQlFBYk13UGFmV1JYUy9VZUpDSGpZTE5taFR5WnNZY3d5czJTZEdRQ2ln?=
 =?utf-8?B?ZndnaEFrSDV3VkJsU3Vwd0tid2pmcUVBcjl4ZFZuUlF6ZkRMYlpIRXhqLzQy?=
 =?utf-8?B?c2hmbjJtend6cVNWUnlNLzQ4TWlrVkNwMEhvNTZoTlRsZDRDeG5XL01EbWN3?=
 =?utf-8?B?VVBTRld0MDVnT1NMRjNhQW1Dc2hTcFp4ZHArcjZJaDZaSFJDNm5YQWRZbkFl?=
 =?utf-8?B?SFpPckd3R2RwNy9PSVJ1bEViMWZQVkdVMG1tYnlaWVBXZ0dCRUJmM213RE1S?=
 =?utf-8?B?NWd6RzdJQnpCbGVjSmFsZmRUM1pWS3g5b2FKRFhTbUsrdThYMFNSL2poSDR0?=
 =?utf-8?B?QWdRMWlvdG4yL2NyeGRhYlREZUsyc21pZVJHTmpCSGdXRnYyZmdiOS9CRFY3?=
 =?utf-8?B?SUxIUU9pU3FyYmk1a2tCRW9sTGcyWERzYmVtN0ZVa3VKTTdQV202enVjY20z?=
 =?utf-8?B?MHBsM0hWMUZ3M3dSUkdKYlZiVFlmTXoxaWJDTjhjRDRoci9OOWRGUWFvSnRp?=
 =?utf-8?B?VWtObUpFTUF0eUVDVFBybDE2ZHJ0WTRSMkh1MGpMcGEzNEhXcTVZaVo4TmhQ?=
 =?utf-8?B?UXF3WmxIL0IrTVU5MDNBMnBUZTBCb0x6YjEzNVh4aUVWR2R1TUplOHJhTnhu?=
 =?utf-8?B?anFrT0ZHN3pHbGFRVkJyT29mMmREWXB6d2xrK2lBR2lQbmRGeVRsQUROV0x2?=
 =?utf-8?B?YkNEd0MxMytCVFc3TXFOMzRtTlFCQjlLQjdGRGsxdmtINGhqMkNVeDV0T2l4?=
 =?utf-8?B?TWs1QjBVT016S0oyazBXcDNsaGlOUWlYVFZNZEh1MUVlenV1U3JGVFV3L1Nm?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F30399D94CB64AA0109D30FDDDC7D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e3f83-eb8f-4c36-60b6-08db3d3d212b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 23:08:16.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIC5vn1OxG2jO+lzrw/97QSvaG7vCG7zPrTgW9my63k/Jo2jxH6ZI2fuTDxVMEaH4TJ0T684KfqSgz0tpHUthPlOH1Hc3Z2YLzrDskZrK+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDIyOjUwIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSA+DQo+ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gDQo+
ID4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMTA6NDA6NDFQTSArMDAwMCwgPg0KPiA+IEtlbHZp
bi5DYW9AbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gV2h5IGlzIHRoZSBs
b2NrIG5lZWRlZCB3aGlsZSByZWFkaW5nIHRoZSBzdGF0dXMgYW5kDQo+ID4gPiA+ID4gPiA+ID4g
d2FpdGluZw0KPiA+ID4gPiA+ID4gPiA+IGZvciBpdCB3aXRoIGxvbmcgZGVsYXlzPw0KPiA+ID4g
PiBUaGVyZSdzIChsb3cpIGNoYW5jZSBvZiBhY2Nlc3MgdG8gdGhlIHNhbWUgY3RybCByZWdpc3Rl
ciBmcm9tDQo+ID4gPiA+IG90aGVyDQo+ID4gPiA+IHBhdGhzIHdoaWNoIG1pZ2h0IGNoYW5nZSB0
aGUgdmFsdWUgb2Ygc3RhdHVzIGluIGFuIHVuZXhwZWN0ZWQNCj4gPiA+ID4gd2F5LiA+ID4gSXQN
Cj4gPiA+ID4gYWxzbyBwcmV2ZW50cyB0aGUgaGFyZHdhcmUgb3BlcmF0aW9uIGZyb20gYmVpbmcg
aW50ZXJydXB0ZWQNCj4gPiA+ID4gdW50aWwgPiA+IGl0DQo+ID4gPiA+IGluZGljYXRlcyBpdCBo
YXMgZmluaXNoZWQgYnkgYSBiaXQgc2V0IGluIHRoZSBzdGF0dXMgcmVnaXN0ZXIuDQo+ID4gDQo+
ID4gV2VsbCwgdGhlIGxvY2sgaXMgb2J2aW91c2x5IHJlcXVpcmVkIHRvIHByb3RlY3RlIHRoZSBy
ZWFkcyB0byB0aGUNCj4gPiByZWdpc3Rlci7CoCBCdXQgd2h5IGRvIHlvdSBuZWVkIHRvIGhvbGQg
dGhlIGxvY2sgb3ZlciB0aGUgcmVhZHMgYW5kDQo+ID4gdGhlIGRlbGF5Pw0KDQpJIHdhbnRlZCB0
byBwcm90ZWN0IHRoZSBjb21wbGV0ZSBoYXJkd2FyZSBvcGVyYXRpb24sIGZyb20ga2ljay1vZmYg
YnkNCmN0cmwgd3JpdGluZyB0byBzdGF0dXMgY2hhbmdlIGluZGljYXRpbmcgY29tcGxldGlvbiwg
d2hpY2ggbWlnaHQNCmludm9sdmVzIGRlbGF5cyBpbiBiZXR3ZWVuIHdoZW4gbW9yZSB0aGFuIDEg
c3RhdHVzIGNoZWNrcyByZXF1aXJlZC4NCg0KDQo=
