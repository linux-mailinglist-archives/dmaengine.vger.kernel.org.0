Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1117BA935
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJESfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjJESfu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 14:35:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A7090;
        Thu,  5 Oct 2023 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696530948; x=1728066948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KW23dgidCWJrnfDQOB2yuGWkosI88Z7cC3z5Np58j10=;
  b=ZglW2OikFnYUq/DFYYTwlIgG3N0kb1IAOj7Pdhngwh2OaaUVV4PBSa9w
   1Z7oq6KPvZ1wdvnoZK2IDKpzKdI8oIlBxpEaky06h717FBGUOrbsR1ICF
   4k7dnjU8M61wLcNhniM9Ev/zPYGXRaDxv28yFpV7NX59Jgy97WNVr1aP5
   p1+rnXzL1tkFvwgmG+vokH5LVGi9rQyPSUqS1KbpOvgRffquIGCvHC8Ve
   ZFnDOAlqU5UwUdCN+QUdXWdZOh8j0oRfh0YhYgq1h9iM7lX7KvCBLJGFU
   erd0LzrXGza2EV2/LU1kcPlRbxL8C9tXWSxW7BgXCGEPIHUAPoBosTe8G
   Q==;
X-CSE-ConnectionGUID: IsFAWIpVRi2wVqnf76dtFg==
X-CSE-MsgGUID: XWo4PkOVSzuB0XyaB6xZQg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="8601577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 11:35:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 5 Oct 2023 11:35:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 5 Oct 2023 11:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO470VbA7AK8/xd62u5IEIyQvIs5ms8/ERbCpXA1jBBW/TvH7zirwMBCIovRhhZ+3DCjZaoVIrqnUW/ZzsYkBg9ZHrRP4REYRWZ1Nqaw3M2qppkbKkt+KnQVFM1b6nZuOMo9ZhVDuQWQem/uuQ33Nxm5ciF9b1OgpshOV2TFO2WYF7PRGbkWdPqk9lpJhF29cKgTMQGDqUs4+HTGLTZ/f5uG5CPAOP9mi1KIrxjgh1MZ8E7nUPdS0iui6ZzPe5Eee4AehtdWu0/NpgzkXtcWsaXqhGfe6cROQvKT5Z5f1bEG8B/7gxFj5IbyunVGrwGpEwdGKWbwLTpdgiGWDTSBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW23dgidCWJrnfDQOB2yuGWkosI88Z7cC3z5Np58j10=;
 b=hZuE5GL6GWDwLtbFueKPT/M/TmXW1rPEGn6Qq+rkyfLWPVJ9zJJ5JW86YOI+LLy0ot6WEArFdUErw4uQGisQEDCidE6DZDYx7tNXNinoRumhwrEqCR7hGUodAjikav+kc6+wbFEUVitfPpwsmslZIltvpvuH04jBYe5amqWLBaGQL7C+P9cR9MDsSh/9ujtaJMSIjvn4efgYPBCPZ1YNpQ/tpn69lvSsA4erfcOowI5iHNMeuYEbOpPVQWMNM7al+fovpdTpGEOhXzgOEc0YCqitflb/0B32ICLVLUSbXav7ZBLRhwAsgHIezoRVc3xfIGH+zUe5VIe4coM+SrPMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW23dgidCWJrnfDQOB2yuGWkosI88Z7cC3z5Np58j10=;
 b=QYitrgE/Ww7We4WLSeUWxE+77qvYnI3besxgPrDNZSEo+sS/W/25KRzbi4EdeYqv1QdGQJxCKsrCEghVpl6ihLi7L9AQ0Rs3d0MecRpkj84qTvDFHGVVbqQnZ8lnY4BrRhlneiWVmx1lZCHm1qaLlNQOxo5hqT4bjFg3hjN7WlE=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 18:35:27 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da%4]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:35:27 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>, <logang@deltatee.com>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gA==
Date:   Thu, 5 Oct 2023 18:35:27 +0000
Message-ID: <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
In-Reply-To: <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|CY5PR11MB6306:EE_
x-ms-office365-filtering-correlation-id: a6c279f5-3484-45b3-2b7d-08dbc5d1d86f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiD4/C5sDcn1Xk6CYS307HO2a5LdiXXOyODmjmDOUqEO3wHAT1Uuh4SbMjjUx5T9pULmf6Z1qqN9ume62SFx5dCUOUV6pUWbv/anw1mKjZVU4jaVf2vLD3tc2XO1SjvxHDfa8UBIu7St/Mcttw/LpdehMcfVxJzNWXWa4r6mf+EEPX+wIGd5vmY3eZniEPnHdruEckb7FB+aOKUnHMMUByPsD+DbtTRLpP9p36rUeCS/QIuvAoiv3QqqxKHPUTjTUogjMYTunXo2FS0OjikQNVClUC1znNHRizYowGV1gNbHjq1HsoW9VAI5GaWakIhuAFfquISVKzZKh3gzLbUcrBrjOCShJrm43G1aeH7AQSDX5kziBk9JyVAZCOggknDs/O3ojI/zWyoqG3d2oujQeAabNdke8WQ2yR/anqI6PxyiEPH1jUEwyd6PvxzYHbQvwqw+LOz6eH3JMSOymQqtXR5ziXY8z7wDnb0/a4blKpF6bWRWHR3S0lX/1kqL5HWR8wTvJNXz2enh9H8zU2UCMf4RaYv+q4tUOrSnfolWGVAQinq4Fc/Aue7c1Z19lEiqzQ0BgCOCcWY1gIe5u2mcNUPDhR/jkFJj+ztWz2/nb3Dzw7pZ5IO1Ls/0X2u1MSVB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(53546011)(6512007)(6506007)(6486002)(71200400001)(478600001)(38070700005)(122000001)(86362001)(38100700002)(2906002)(83380400001)(26005)(2616005)(36756003)(66446008)(64756008)(54906003)(76116006)(5660300002)(66946007)(66556008)(6916009)(66476007)(8936002)(41300700001)(4326008)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFNzZXNOS1dqdExxbjNmSGI4dHQyOGU4cFpncHRNSzBHWXYzbFUvRUMzc1NJ?=
 =?utf-8?B?aTRLVVpqcHpheHRDNlg2UGNPbW1naGc0MHA1cDJSUTZwR0ZheHR0TExFYU94?=
 =?utf-8?B?MEVZOEJXYlhIVi9JZ3NqcTdnVVAzY1ZHS0NMTjJXVlJyaWNiVVppQXRjSXZt?=
 =?utf-8?B?dVFndlJPa1prNVkrSGxRVndlcDQ2djhLWGJNSTQyd2FjL2s2dXE4VmZjVlNx?=
 =?utf-8?B?VlBkL001NTV3VWJ2ajVqSThjVmVRVktqenVPYWpMWnVSRmlFNzZ6d2pVRVZr?=
 =?utf-8?B?bUhKTkQ5ZzR0NnE5N1k2RWN1VnRRQTV3a29MMFEyRGh3cUpNWnFtZFJSbE94?=
 =?utf-8?B?MjU5WDJxdE5FcVpONHFOR1p3c3h1Tm9KSERGNTduc09wMCs3Qm1taWp3NDd4?=
 =?utf-8?B?REpha2htc2NRaElZaTRNV1NEQWtqM1F1a09MMDkxQlVIMXZxWFZtK1Y4QWtY?=
 =?utf-8?B?SDAvZXRPNUVzRUd4SXdveFdyT2NpWXFINXplN2pzUnAyR1JhakVjL215L0Ju?=
 =?utf-8?B?Vk16WEk1ZEV0WjB3UkREVDhxQUc2emRXemh4QlpSd25ONGEwU3RxS0h6U2Ix?=
 =?utf-8?B?WCtIYlRYckdyQVowVENZbTRlVmhEWGZGNVZGQ05HeXhaZzNCMkRuZ1haR3hS?=
 =?utf-8?B?NjV3dXFjMkNBTzhCNkF2cm9wQUJYcHBqSWlyS3I5OHZkYnR3bnFPb1pmSzFa?=
 =?utf-8?B?Mnd2K0ZsZHNZdUxBdm4wWXp2RFdTVHh0WFZLZlQ0WFNWTDNJTnBXbUpaWFBR?=
 =?utf-8?B?T0JXdkl2L1d5TjZ3cXF4ZjJqd0ZxUC9OU1FOQjZIVnEwSWVycFNJb0xDWG9O?=
 =?utf-8?B?OU4zQ1I2UldVcngxNFYvVXBoVENNTkZkdzRvN2pyMDFEeHNpNEg3RENZUWQ5?=
 =?utf-8?B?ckgrNlNSY1VZa3Y4NlRHY3EvMjVwYU9iUVlROTlVR0ErUWhvM2pjZFMvYWs3?=
 =?utf-8?B?MTltMU5lNCtCb3daWkF1ZzY0TmQ3d0JSWGxSa1JaVytmSVVjbVA2bnhZQ2sy?=
 =?utf-8?B?bmtUeWZaMGZxYUZuR0dnV3RsaTB5Vkw2QjRxRUZiK3ZjbWtrWHBFU3F3cith?=
 =?utf-8?B?V2FocFR2ZXJlOGx0bkV1Y3pxYzk1R1dCSUNsVWx0dzdnWGNGMHlrdCsxOGR6?=
 =?utf-8?B?dWxocnNDWlpoZHBsMEtlVDd0VUVOY2kzcVVFa0ZEZDV4TmpEdzhCWG9ESWt3?=
 =?utf-8?B?R2IrM0FZZ0d6VnRoRm56MUxZaFZrRlRtcy9tZGtxUXBGcnRhYzhPQW1RRVp3?=
 =?utf-8?B?RFFBZDUvVmNDTTBXV01JakF4TEpmSTZDdkVjVWZjM3lUTXBsTXArdU5hRUNW?=
 =?utf-8?B?aTUzRGNpK1dJcVg0S1h0MnJYNnM4VGtkc2s4VHRKNDRNWm4vZG5Mc3R6UUp3?=
 =?utf-8?B?L0xaTjVQNXZvd3pudVdJVmNmZ1kyNVJ0NUkxWUxQVFdYZnNQV293RTBYVmh1?=
 =?utf-8?B?UnlkRTMxeHY1U0ZNTytNYXY5UHdnVmcwWXlVekZ4azRzTDZzL3NldmZXeVNC?=
 =?utf-8?B?MEp2NGFWdmduR3RNSjNHcFByaXhBR3MxUHBjV0JBcGpLNnkrdjV4UGxsc2h1?=
 =?utf-8?B?aGNRMXVvb1pxMHA4bU1TVVRSRDNYOVFZM3hQazNnQ0J4TG1ObGhUSG1pbE5S?=
 =?utf-8?B?cTRlc21DMWVHaVZTaXdQakVhNFhkcUJuWjF4TmpwcHBYd0F3UDBLM3MxZXN1?=
 =?utf-8?B?WFh4L3BRQSt0c2Vwbm1hNnpXTlArWGs5b1BBdTR4OFYybzdkbUNnejJva0xT?=
 =?utf-8?B?TENRTTd5WUFjSVhvclNYRHlLTzlFNjRDSUV0Ti8yOThrUmhvTUpuOXpQWXNz?=
 =?utf-8?B?RlFzZWFEMk5MTGlUc3I0YXJ1RlFGUHlqZ0dTVVhIWUE2VUVGd01uZFk2RFRp?=
 =?utf-8?B?SGN1cWNiMFpYeTl0eHJid24xRXBnSWE4MWZyRkNDZmFSM1F2LzJTV2h6SUpM?=
 =?utf-8?B?VURyZktvN1hXZ1VLMDNTR0tBY2phVVRtZWxrcnZqVDZERVVJT2lPd1V2VndW?=
 =?utf-8?B?V2JFa2w2cWhTa2x2RjZzTEtzZkVhSGVRVDVCaUllTXYyazJQZnBqSmtQZjNa?=
 =?utf-8?B?bUNZNjY3Q3Z2M3hqZ0JsMTRzRVBPOHFVQkV0bnBWQlUxb2FTRnZ1SE5FRVlq?=
 =?utf-8?B?R3oxeWcvWnhTa20rY0krWUpLdHZWYnVvdkpOS0NrSEhURzQ3QjJYd1BzTkhG?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A98E864D12789F47A549AE2E8302CE8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c279f5-3484-45b3-2b7d-08dbc5d1d86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 18:35:27.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZuF21J3f+iMtZ2VBTRGFhn7KVDZ8hdjAami76do98acoqh/kTh7boLEF8cMgrVW3axWdF7Me4RHmUeP1Ykk/eCZMe6desfqHoeif07eASw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsCgpSZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIGNvbW1lbnQuIERvIHlvdSBzdGlsbCBo
YXZlIGNvbmNlcm5zIG9uIHRoZXNlCnBhdGNoZXM/IFdlIGFyZSBhcHByb2FjaGluZyB0aGUgcHJv
ZHVjdCByZWxlYXNlIGFuZCByZWFsbHkgaG9wZSB0byBnZXQKdGhlIGRyaXZlciBtZXJnZWQgdG8g
dGhlIGtlcm5lbC4gVGhlIHBhdGNoZXMgaGF2ZSBnb3QgYXBwcm92YWxzIGZyb20Kb3RoZXIgcmV2
aWV3ZXJzLiBJIGFwcHJlY2lhdGUgaXQgaWYgeW91IGNhbiBhcHBseSBpdCBvciBqdXN0IGxldCBt
ZQprbm93IGlmIHlvdSBoYXZlIGFueSBjb21tZW50IG9yIGNvbmNlcm4uCgpUaGFuayB5b3UgdmVy
eSBtdWNoIQoKS2VsdmluCgpPbiBUaHUsIDIwMjMtMDgtMDMgYXQgMDM6MTUgKzAwMDAsIEtlbHZp
bi5DYW9AbWljcm9jaGlwLmNvbSB3cm90ZToKPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQo+IAo+IE9uIFdlZCwgMjAyMy0wOC0wMiBhdCAwMDoxMiArMDUzMCwgVmlub2QgS291
bCB3cm90ZToKPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91Cj4gPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiA+IAo+
ID4gT24gMjgtMDctMjMsIDEzOjAzLCBLZWx2aW4gQ2FvIHdyb3RlOgo+ID4gCj4gPiA+ICtzdGF0
aWMgc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICoKPiA+ID4gK3N3aXRjaHRlY19kbWFf
cHJlcF9tZW1jcHkoc3RydWN0IGRtYV9jaGFuICpjLCBkbWFfYWRkcl90Cj4gPiA+IGRtYV9kc3Qs
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFf
YWRkcl90IGRtYV9zcmMsIHNpemVfdCBsZW4sIHVuc2lnbmVkCj4gPiA+IGxvbmcgZmxhZ3MpCj4g
PiA+ICvCoMKgwqDCoCBfX2FjcXVpcmVzKHN3ZG1hX2NoYW4tPnN1Ym1pdF9sb2NrKQo+ID4gPiAr
ewo+ID4gPiArwqDCoMKgwqAgaWYgKGxlbiA+IFNXSVRDSFRFQ19ERVNDX01BWF9TSVpFKSB7Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogS2VlcCBzcGFyc2UgaGFwcHkgYnkgcmVzdG9yaW5nIGFuIGV2ZW4gbG9jawo+
ID4gPiBjb3VudAo+ID4gPiBvbgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0
aGlzIGxvY2suCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fYWNxdWlyZShzd2RtYV9jaGFuLT5zdWJtaXRfbG9jayk7
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4gPiA+ICvCoMKg
wqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIHJldHVybiBzd2l0Y2h0ZWNfZG1hX3ByZXBf
ZGVzYyhjLCBNRU1DUFksCj4gPiA+IFNXSVRDSFRFQ19JTlZBTElEX0hGSUQsCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRtYV9kc3QsCj4gPiA+IFNXSVRDSFRFQ19JTlZBTElEX0hGSUQsIGRtYV9zcmMs
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIGxlbiwgZmxhZ3MpOwo+ID4gPiArfQo+ID4gPiArCj4g
PiA+ICtzdGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICoKPiA+ID4gK3N3aXRj
aHRlY19kbWFfcHJlcF93aW1tX2RhdGEoc3RydWN0IGRtYV9jaGFuICpjLCBkbWFfYWRkcl90Cj4g
PiA+IGRtYV9kc3QsIHU2NCBkYXRhLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFncykKPiA+IAo+ID4gY2Fu
IHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHRoaXMgd2ltbSBkYXRhIHJlZmVycyB0by4uLgo+ID4g
Cj4gPiBJIHRoaW5rIGFkZGluZyBpbW0gY2FsbGJhY2sgd2FzIGEgbWlzdGFrZSwgd2UgbmVlZCBh
IGJldHRlcgo+ID4ganVzdGlmaWNhdGlvbiBmb3IgYW5vdGhlciB1c2VyIGZvciB0aGlzLCB3aG8g
cHJvZ3JhbXMgdGhpcywgd2hhdAo+ID4gZ2V0cwo+ID4gcHJvZ3JhbW1lZCBoZXJlCj4gCj4gU3Vy
ZS4gSSB0aGluayBpdCdzIGFuIGFsdGVybmF0aXZlIG1ldGhvZCB0byBwcmVwX21lbSBhbmQgd291
bGQgYmUKPiBtb3JlCj4gY29udmVuaWVudCB0byB1c2Ugd2hlbiB0aGUgd3JpdGUgaXMgOC1ieXRl
IGFuZCB0aGUgZGF0YSB0byBiZSBtb3ZlZAo+IGlzCj4gbm90IGluIGEgRE1BIG1hcHBlZCBtZW1v
cnkgbG9jYXRpb24uIEZvciBleGFtcGxlLCB3ZSB3cml0ZSB0byBhCj4gZG9vcmJlbGwgcmVnaXN0
ZXIgd2l0aCB0aGUgdmFsdWUgZnJvbSBhIGxvY2FsIHZhcmlhYmxlIHdoaWNoIGlzIG5vdAo+IGFz
c29jaWF0ZWQgd2l0aCBhIERNQSBhZGRyZXNzIHRvIG5vdGlmeSB0aGUgcmVjZWl2ZXIgdG8gY29u
c3VtZSB0aGUKPiBkYXRhLCBhZnRlciBjb25maXJtaW5nIHRoYXQgdGhlIHByZXZpb3VzbHkgaW5p
dGlhdGVkIERNQSB0cmFuc2FjdGlvbnMKPiBvZiB0aGUgZGF0YSBoYXZlIGNvbXBsZXRlZC4gSSBh
Z3JlZSB0aGF0IHRoZSB1c2Ugc2NlbmFyaW8gd291bGQgYmUKPiB2ZXJ5Cj4gbGltaXRlZC4KPiA+
IAo+ID4gPiArwqDCoMKgwqAgX19hY3F1aXJlcyhzd2RtYV9jaGFuLT5zdWJtaXRfbG9jaykKPiA+
ID4gK3sKPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2NoYW4gKnN3ZG1hX2No
YW4gPQo+ID4gPiB0b19zd2l0Y2h0ZWNfZG1hX2NoYW4oYyk7Cj4gPiA+ICvCoMKgwqDCoCBzdHJ1
Y3QgZGV2aWNlICpjaGFuX2RldiA9IHRvX2NoYW5fZGV2KHN3ZG1hX2NoYW4pOwo+ID4gPiArwqDC
oMKgwqAgc2l6ZV90IGxlbiA9IHNpemVvZihkYXRhKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqAg
aWYgKGxlbiA9PSA4ICYmIChkbWFfZHN0ICYgKCgxIDw8IERNQUVOR0lORV9BTElHTl84X0JZVEVT
KQo+ID4gPiAtCj4gPiA+IDEpKSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dl9lcnIoY2hhbl9kZXYsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJRVyBXSU1NIGRzdCBhZGRyIDB4JTA4eF8lMDh4IG5vdCBRVwo+ID4gPiBhbGlnbmVk
IVxuIiwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXBw
ZXJfMzJfYml0cyhkbWFfZHN0KSwKPiA+ID4gbG93ZXJfMzJfYml0cyhkbWFfZHN0KSk7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogS2VlcCBzcGFyc2UgaGFwcHkgYnkgcmVzdG9yaW5nIGFuIGV2ZW4gbG9jawo+ID4g
PiBjb3VudAo+ID4gPiBvbgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGlz
IGxvY2suCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fYWNxdWlyZShzd2RtYV9jaGFuLT5zdWJtaXRfbG9jayk7Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4gPiA+ICvCoMKgwqDC
oCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIHJldHVybiBzd2l0Y2h0ZWNfZG1hX3ByZXBfZGVz
YyhjLCBXSU1NLAo+ID4gPiBTV0lUQ0hURUNfSU5WQUxJRF9IRklELCBkbWFfZHN0LAo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBTV0lUQ0hURUNfSU5WQUxJRF9IRklELCAwLAo+ID4gPiBkYXRhLCBsZW4s
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdzKTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gCj4gPiAu
Li4KPiA+IAo+ID4gPiArc3RhdGljIGludCBzd2l0Y2h0ZWNfZG1hX2FsbG9jX2Rlc2Moc3RydWN0
IHN3aXRjaHRlY19kbWFfY2hhbgo+ID4gPiAqc3dkbWFfY2hhbikKPiA+ID4gK3sKPiA+ID4gK8Kg
wqDCoMKgIHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2RldiAqc3dkbWFfZGV2ID0gc3dkbWFfY2hhbi0K
PiA+ID4gPnN3ZG1hX2RldjsKPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBjaGFuX2Z3X3JlZ3MgX19p
b21lbSAqY2hhbl9mdyA9IHN3ZG1hX2NoYW4tCj4gPiA+ID4gbW1pb19jaGFuX2Z3Owo+ID4gPiAr
wqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc3dp
dGNodGVjX2RtYV9kZXNjICpkZXNjOwo+ID4gPiArwqDCoMKgwqAgc2l6ZV90IHNpemU7Cj4gPiA+
ICvCoMKgwqDCoCBpbnQgcmM7Cj4gPiA+ICvCoMKgwqDCoCBpbnQgaTsKPiA+ID4gKwo+ID4gPiAr
wqDCoMKgwqAgc3dkbWFfY2hhbi0+aGVhZCA9IDA7Cj4gPiA+ICvCoMKgwqDCoCBzd2RtYV9jaGFu
LT50YWlsID0gMDsKPiA+ID4gK8KgwqDCoMKgIHN3ZG1hX2NoYW4tPmNxX3RhaWwgPSAwOwo+ID4g
PiArCj4gPiA+ICvCoMKgwqDCoCBzaXplID0gU1dJVENIVEVDX0RNQV9TUV9TSVpFICogc2l6ZW9m
KCpzd2RtYV9jaGFuLT5od19zcSk7Cj4gPiA+ICvCoMKgwqDCoCBzd2RtYV9jaGFuLT5od19zcSA9
IGRtYV9hbGxvY19jb2hlcmVudChzd2RtYV9kZXYtCj4gPiA+ID4gZG1hX2Rldi5kZXYsIHNpemUs
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmc3dkbWFfY2hhbi0KPiA+ID4g
PiBkbWFfYWRkcl9zcSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9O
T1dBSVQpOwo+ID4gPiArwqDCoMKgwqAgaWYgKCFzd2RtYV9jaGFuLT5od19zcSkgewo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjID0gLUVOT01FTTsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfYW5kX2V4aXQ7Cj4gPiA+ICvCoMKgwqDCoCB9Cj4gPiA+
ICsKPiA+ID4gK8KgwqDCoMKgIHNpemUgPSBTV0lUQ0hURUNfRE1BX0NRX1NJWkUgKiBzaXplb2Yo
KnN3ZG1hX2NoYW4tPmh3X2NxKTsKPiA+ID4gK8KgwqDCoMKgIHN3ZG1hX2NoYW4tPmh3X2NxID0g
ZG1hX2FsbG9jX2NvaGVyZW50KHN3ZG1hX2Rldi0KPiA+ID4gPiBkbWFfZGV2LmRldiwgc2l6ZSwK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZzd2RtYV9jaGFuLQo+ID4gPiA+
IGRtYV9hZGRyX2NxLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX05P
V0FJVCk7Cj4gPiA+ICvCoMKgwqDCoCBpZiAoIXN3ZG1hX2NoYW4tPmh3X2NxKSB7Cj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmMgPSAtRU5PTUVNOwo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gZnJlZV9hbmRfZXhpdDsKPiA+ID4gK8KgwqDCoMKgIH0KPiA+ID4g
Kwo+ID4gPiArwqDCoMKgwqAgLyogcmVzZXQgaG9zdCBwaGFzZSB0YWcgKi8KPiA+ID4gK8KgwqDC
oMKgIHN3ZG1hX2NoYW4tPnBoYXNlX3RhZyA9IDA7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIHNp
emUgPSBzaXplb2YoKnN3ZG1hX2NoYW4tPmRlc2NfcmluZyk7Cj4gPiA+ICvCoMKgwqDCoCBzd2Rt
YV9jaGFuLT5kZXNjX3JpbmcgPSBrY2FsbG9jKFNXSVRDSFRFQ19ETUFfUklOR19TSVpFLAo+ID4g
PiBzaXplLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9OT1dBSVQpOwo+ID4gPiArwqDCoMKg
wqAgaWYgKCFzd2RtYV9jaGFuLT5kZXNjX3JpbmcpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByYyA9IC1FTk9NRU07Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBmcmVlX2FuZF9leGl0Owo+ID4gPiArwqDCoMKgwqAgfQo+ID4gPiArCj4gPiA+ICvCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgU1dJVENIVEVDX0RNQV9SSU5HX1NJWkU7IGkrKykgewo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2MgPSBremFsbG9jKHNpemVvZigqZGVzYyksIEdG
UF9OT1dBSVQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghZGVzYykgewo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IC1FTk9N
RU07Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
ZnJlZV9hbmRfZXhpdDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ICsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvcl9p
bml0KCZkZXNjLT50eGQsCj4gPiA+ICZzd2RtYV9jaGFuLQo+ID4gPiA+IGRtYV9jaGFuKTsKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjLT50eGQudHhfc3VibWl0ID0gc3dpdGNo
dGVjX2RtYV90eF9zdWJtaXQ7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy0+
aHcgPSAmc3dkbWFfY2hhbi0+aHdfc3FbaV07Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGVzYy0+Y29tcGxldGVkID0gdHJ1ZTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN3ZG1hX2NoYW4tPmRlc2NfcmluZ1tpXSA9IGRlc2M7Cj4gPiA+ICvCoMKgwqDC
oCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIHJjdV9yZWFkX2xvY2soKTsKPiA+ID4gK8KgwqDC
oMKgIHBkZXYgPSByY3VfZGVyZWZlcmVuY2Uoc3dkbWFfZGV2LT5wZGV2KTsKPiA+ID4gK8KgwqDC
oMKgIGlmICghcGRldikgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjdV9yZWFk
X3VubG9jaygpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjID0gLUVOT0RFVjsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfYW5kX2V4aXQ7Cj4gPiA+
ICvCoMKgwqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIC8qIHNldCBzcS9jcSAqLwo+ID4g
PiArwqDCoMKgwqAgd3JpdGVsKGxvd2VyXzMyX2JpdHMoc3dkbWFfY2hhbi0+ZG1hX2FkZHJfc3Ep
LCAmY2hhbl9mdy0KPiA+ID4gPiBzcV9iYXNlX2xvKTsKPiA+ID4gK8KgwqDCoMKgIHdyaXRlbCh1
cHBlcl8zMl9iaXRzKHN3ZG1hX2NoYW4tPmRtYV9hZGRyX3NxKSwgJmNoYW5fZnctCj4gPiA+ID4g
c3FfYmFzZV9oaSk7Cj4gPiA+ICvCoMKgwqDCoCB3cml0ZWwobG93ZXJfMzJfYml0cyhzd2RtYV9j
aGFuLT5kbWFfYWRkcl9jcSksICZjaGFuX2Z3LQo+ID4gPiA+IGNxX2Jhc2VfbG8pOwo+ID4gPiAr
wqDCoMKgwqAgd3JpdGVsKHVwcGVyXzMyX2JpdHMoc3dkbWFfY2hhbi0+ZG1hX2FkZHJfY3EpLCAm
Y2hhbl9mdy0KPiA+ID4gPiBjcV9iYXNlX2hpKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqAgd3Jp
dGV3KFNXSVRDSFRFQ19ETUFfU1FfU0laRSwgJnN3ZG1hX2NoYW4tPm1taW9fY2hhbl9mdy0KPiA+
ID4gPiBzcV9zaXplKTsKPiA+ID4gK8KgwqDCoMKgIHdyaXRldyhTV0lUQ0hURUNfRE1BX0NRX1NJ
WkUsICZzd2RtYV9jaGFuLT5tbWlvX2NoYW5fZnctCj4gPiA+ID4gY3Ffc2l6ZSk7Cj4gPiAKPiA+
IHdoYXQgaXMgd3JpdGUgaGFwcGVuaW5nIGluIHRoZSBkZXNjcmlwdG9yIGFsbG9jIGNhbGxiYWNr
LCB0aGF0IGRvZXMKPiA+IG5vdAo+ID4gc291bmQgY29ycmVjdCB0byBtZQo+IAo+IEFsbCB0aGUg
cXVldWUgZGVzY3JpcHRvcnMgb2YgYSBjaGFubmVsIGFyZSBwcmUtYWxsb2NhdGVkLCBzbyBJIHRo
aW5rCj4gaXQncyBwcm9wZXIgdG8gY29udmV5IHRoZSBxdWV1ZSBhZGRyZXNzL3NpemUgdG8gaGFy
ZHdhcmUgYXQgdGhpcwo+IHBvaW50Lgo+IEFmdGVyIHRoaXMgaW5pdGlhbGl6YXRpb24sIHdlIG9u
bHkgbmVlZCB0byBhc3NpZ24gY29va2llIGluIHN1Ym1pdAo+IGFuZAo+IHVwZGF0ZSBxdWV1ZSBo
ZWFkIHRvIGhhcmR3YXJlIGluIGlzc3VlX3BlbmRpbmcuCj4gCj4gS2VsdmluCj4gCgo=
