Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C016224EA
	for <lists+dmaengine@lfdr.de>; Wed,  9 Nov 2022 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIHyR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Nov 2022 02:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIHyQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Nov 2022 02:54:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30D17AAD;
        Tue,  8 Nov 2022 23:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667980455; x=1699516455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TCHQHy2nzDOvI6tcy2n6Io50Hn2LJA5CTnnBsEr3yeQ=;
  b=z4J11fTbxGE2LRy7hJ7iKpo5VgoHeFm5PUCFLpaKoqNAp2yYEc0XE+NZ
   +hHRJVHGZBqjLxeOf9PPl/36Z+ct8BbBp4LtYVdmpB4hunA4eto8s2l7j
   VUD7bF+7nFlO1JUGvtO6SHrR2PeIOwZ49McTP5P367zMWAk2E2QjeA+WF
   Tbf1ahOEZOwdfcc7EYw88eosCGb9QIOD0lZ2x9eZ4tw6QYMX9p9X7upR8
   5MO6wY+R5iDNuzDco914Ql4qXGOhCvUYn4Eghl+1UlaDS3FIDziJxs50X
   VKTYLNCaLxGLELOElkIF35Ne3SVgGPDEDe47UzgPz8eeuIc6ntpATGbYs
   A==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="199025412"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Nov 2022 00:54:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 9 Nov 2022 00:54:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 9 Nov 2022 00:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY6P4X0sI3DMba4ICdBAoWmpQiFTSPMsyMgBZOTGO3HRbJiqJcAq1mfPdUCixjnH3av5QowFRF+vF4fVAQIAOeXWqJzbDtkTPrxDuhWn5R2n2lIK7JIQcFoJRuqnpP41t26XGEPAqladeKhnvhjIndVNhcRHFdp3vqwopEVTy/zzuxSA/ZgXe3kc2SZLCgcIgcRR4ba8veCY32eWlbKumNytC5/8Z570DbL2pLaLPL2hvi7Zga5XEBtiP2IOsRrrRUPPbJc32ohML5t0iGC7Tg3yXmpuCNZlPq1Xjf+aXvTh1aDj0pNrUvuAnBDRMV1FggYPG4igDoe2xWakJxbauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCHQHy2nzDOvI6tcy2n6Io50Hn2LJA5CTnnBsEr3yeQ=;
 b=WgwrW5k9qHXch9huck8xQwcbUagyda1j+I7K7+M7VgmWpx4esujYQZkQwvBYuZsXnGPO/B39/TF1C9PnsXYJBTOuLLYBogPqRcv5ya0PLtinw25K0Xgg4rtIqgCRun47GMo6dsgqlH6wK0XjHiOcT5TqJuUb1qaVX7suMJqymh0n+me1sM5pJjg6tdpWCbsWNyAIgqmiSX0ziefnJX0lek/8Bqc+XfXF0AIXH9pq7uK9ZXTkDf5UdTYpup86Jyn7Xnc5TkJezI+JhBhpkXA+FpR17N9+ZpT461uSkmWvXzpkuNWPqMCggGJQFov2ekfobefdLzL/6i+fZqlp2q0ePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCHQHy2nzDOvI6tcy2n6Io50Hn2LJA5CTnnBsEr3yeQ=;
 b=aVg2Y+GIBbilHt3dFP5rpYrqbY5Zdu88vzKXxL9+wwwDtGDMcXpjoKkuZbdo8B1e1p4ndZ/+JWdyZmJP0p4+CihV0K7K5HyMtghVfqkXpZGunKLEXHfRAynfg/yoxyzrc4E3rPusuvs3VwXGrSn9iOoRPOjHqV55TQUZJPfPi4Q=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 IA0PR11MB7260.namprd11.prod.outlook.com (2603:10b6:208:43b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 07:54:08 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%4]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 07:54:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <lars@metafoo.de>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <green.wan@sifive.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <ldewangan@nvidia.com>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>, <peter.ujfalusi@gmail.com>,
        <michal.simek@xilinx.com>, <tony@atomide.com>,
        <krzysztof.kozlowski@linaro.org>, <trix@redhat.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>,
        <harini.katakam@xilinx.com>, <swati.agarwal@amd.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: drivers: Use
 devm_platform_ioremap_resource()
Thread-Topic: [PATCH v2] dmaengine: drivers: Use
 devm_platform_ioremap_resource()
Thread-Index: AQHY9BBxbpZzmOa79kmHJcnM/N08GA==
Date:   Wed, 9 Nov 2022 07:54:08 +0000
Message-ID: <1f33df58-50e3-5cbc-7722-792473f2b738@microchip.com>
References: <20221108121837.540293-1-tudor.ambarus@microchip.com>
In-Reply-To: <20221108121837.540293-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|IA0PR11MB7260:EE_
x-ms-office365-filtering-correlation-id: 0dc460a5-e117-483f-8817-08dac22794ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Xy6h1E/RB3RO9aqSubf1Sz5olxVOEljyaLLgyIH5/BqrkxhZPk+0Nxn+xwY28/Mp7KzZkvVY8NVhfodEHvCiLqHPI5Gi880CvSJZcJHpMWEk84xoXNWAqSaqLRnb0svY68zNFLkqdmrk7SegnWDDg+DO+NyD/N02RR1zSu/+BpuiH+P50lxzc6cWI3GCXgCJxsWb2wmpiKNBE8YMAMIbT+mAQNZE1IqHz9/nmEukmWuRxqYv+nJxlfXyvdAjnfpMkIBohRJQ5MVC3AlOYrd9pJLY0OThNveqiIfyIfn8jnZNw5Mce/X3uOrULBFi0tZI+xrm+v5vIhasS4hE6eRUwTfloveFWBzcG7YNADFmwwKDcH0tMVYN9h/i0hFfDY4p9HQqx2+2aBn5C9CB/WfHXG3JW4ar3YIyOKVkuPJYrX63ye+4667veoJ4D2sY9LwTW0SfQr5jxAZTn6pEtVvXHA641+vnTpzCqc0Lryz4ay58qUS5vyJlx3FLipfpr1xd0ao42G+TJgOxSxyh5VixmFSzJnFarEIomJQPth9ZkZGaZ1U7rt96a7T3UL38M2tMeRRuY4XbRE1YX70UX4gBBJaTdEC83e0jAb5ovZENvrdwAXS2V6ONvl93jxiUPqAadyf1NOXcFpkUPaOZrYtwrt/kCkOWnOTSYYhiqU+17UpjAFLK3A8h2quUGjiEobKk+eq4GZwIBHWakjljAdtNnRmu9kxBUKZ2T4MVrcMf6UT9rwvNS36nhG5CZ8nKf+8DJzKDOBg1233jJnai/4T8UHUjuPBKzK4UhdUeL8RQ+IgTGOlQR/VhhMw/NaqqvPsO3yvMoORItfKBGHbodBG/wWL3l71QndMD0wtTm/qJ7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(558084003)(6506007)(186003)(36756003)(7416002)(7406005)(2616005)(316002)(5660300002)(2906002)(122000001)(6512007)(86362001)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(38100700002)(26005)(4326008)(31696002)(91956017)(8936002)(41300700001)(71200400001)(6486002)(478600001)(31686004)(38070700005)(54906003)(6916009)(41080700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnFzczdPS3JPMlpnZUFaTEpoT3BhUjNTTm42ejVGUHdHdis0TlRINER4bitR?=
 =?utf-8?B?ZlFaWisvM0JJcTBoajB0aGZNVjFEeTFWQnluQXJzSjJkd2VhMkNubWdXeHhh?=
 =?utf-8?B?N0pwR2xHUmZ2a0EwQWxzN3VMYkgvU1UrcHcwQ0RSWG0vV1RkcWd5MTNBNkNu?=
 =?utf-8?B?S2VyMzJNc1ljd2RGU3pOOUxJaC8xbDJ3SEh4WUJJYmRHaXlsc2NKYVhjRGl6?=
 =?utf-8?B?VmFKMkRPWXo1aEdUTVZSWE5FZXRHZjB3VURkWlRUWVhOS0prbndGWlhmejNK?=
 =?utf-8?B?VDA0NW1XTTFDaG5ja0dIUU00SXMxd2E5amVsM0dXWTVKUWtsQW1Udm1JZ01v?=
 =?utf-8?B?SDRxUnFYN3lFd0lleGxoTkJUeEJwQlNHTkpDNGZwZXA2MmxUa3B5VUowb2ZK?=
 =?utf-8?B?enJnbkpIUC94MGp3VUJtTlN5aWFGaU4wTUt1VHRub05GbXZxMWoyU2hSVEYv?=
 =?utf-8?B?M1h1MHA3YVBja0hSTmlkT1VwS2FuRDhYbGc3dDI0QmxnSlR2RVBucEJXL0RK?=
 =?utf-8?B?d0JUQjE1Z1A0aTFmUDRZOHVlb0RrYkk5OGdrekRLNUNBbWdKRkVBeG9jUnZV?=
 =?utf-8?B?QVZETHJQK2F0SEozbHFVTmtzSkJDZ2xGbnhhejErYkdNTEdzd0F3WWZTdm9U?=
 =?utf-8?B?eVlzWkNlSSsybEcvMnZtM2VoOCtwdmF4WUUxb3JPNWo3TzRLOWh0ZFphUFli?=
 =?utf-8?B?SG9UQ1lwTC92OTY0VXlGZXdBQi9oaWk3RVI0eWRHbEFOOWJlc2MzM0ZXdDVG?=
 =?utf-8?B?SThQL2d5Nkd0d1BDZlNXTVptd1c5Rk5BYXh1OEVCcjM1OEdadlJjSFVoL1RP?=
 =?utf-8?B?RGEwK0Z0ejQzSmRyRG9PNmhkT2sxUFBTYUdlVmRGSFhLMjBhTkQrWGtGT0kz?=
 =?utf-8?B?cHpVV3dUeGNBQnovQjJ5ZG1NcUhkZTYrWWY4RUNJWTJpVG16RGFNaFR3MmJI?=
 =?utf-8?B?UEZhQVNheWI5WldGMFRQbnhPOVh3WXlleG9kQkx2K1dnajRYNUh1TnY1Sm0r?=
 =?utf-8?B?bCtUeVowZ3FySmQrUk5IMEcwVE5EY1JVKzVWUnBSK2dJWFNheDQ0VWVWeXJl?=
 =?utf-8?B?Wi9VbTRXRVZYM0h5bHVLMDdINmozbkxqMXFyTTljNGtBVGh6N3FhN3d1TFpK?=
 =?utf-8?B?L0g5U0p2cnVnUTFBZ1pwWFhJdlBTaGcrRHZUTUR0cUhqbTEvckRWMUsrYnhj?=
 =?utf-8?B?NWdKMGs4c2t6MnpnaUxxTDJEczZJU2pSVEFudFBka2U4NUgxRGx2UEtMNmd1?=
 =?utf-8?B?Lzhucm5pbDVTWGk4YjNUWStOQjc2U0NpUE1jK1NvWnNwcWNqRWdvM3NqTVpw?=
 =?utf-8?B?d2xZSHpRd1RsQWx0YktlTEllck5VVkcyWmloeW5tVkNkUnNHQllnQTNNdXBs?=
 =?utf-8?B?RHpqWi9tQUJXUEhKYWxjell4V1BLOVlObm44S1BqQ3NGVmpjRmpHQ1hlZldV?=
 =?utf-8?B?azJlbmFkLzhpVHJzd2FJaTJTRnQ4WHFZTmdKbHRDa1RVek5tSHZTV282bWlq?=
 =?utf-8?B?TGlBRGdIT2xRenhpZ2tGOS9ZK1pPNEtFK3puMWdUbDFhVDkvOUpDQ0prQjda?=
 =?utf-8?B?a3BnejVuTlZlMmdESURGK2FHeTZ0RW5RMlF0SVQzRklpUUs1L092UjZNRHhS?=
 =?utf-8?B?MFA3cUNwbXFQRHV1NVJ3MHdwWlF4bENFYW1iOXZDMU43UDloaVZVVmlvV280?=
 =?utf-8?B?RDlpakRhbSs4K0FxbzlENDJWbFB5VEVldGs2MG1VQnVCTzlYS3l1dmY5Y0p6?=
 =?utf-8?B?VHdINE5tVmxIRDFxbzZObFFHZU1xa1ZiMk03RE9vSVBvb2lJR0FyN2dwc1Jx?=
 =?utf-8?B?S2l6blRQY2dhYlhsMzFLY09ibnUrUENnSzd4STJQSWZpdGl3VENLd2VoSUZj?=
 =?utf-8?B?U1dUV0RNY29BblcyakRrbkYxczVjem1MSDhiOUFzU3lGWEYzMkliZ28veDEz?=
 =?utf-8?B?RkZJZWc3QzRXZDN2TTIvUGpuNk1aMTM4cW40NERHTzQvdXhpWWxwSU50Zysr?=
 =?utf-8?B?OWF0SGt5bVViYUk4NFV2dWZEUExnTkpPQURoZXYweXllY3J1MnZ3M1pWOUNI?=
 =?utf-8?B?cU0zZFFUZ1ZWOEpycmI4KytpTEhpamgvOVlMK0YzcHRvWVpoWDJJM09Eb0Ev?=
 =?utf-8?B?M3F0NFMvMUhlUkRGSTViWHJmWkZrZnRiNWl4Q2pnUUs2T25INi9Sd3JTV0NY?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E14D91AB72CB714996184F8E7163AEAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc460a5-e117-483f-8817-08dac22794ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 07:54:08.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3Pn7MnCyB1IcSHDmcElEOydDCis66gpEFesz1tedwPA7BQrhjPOSxzxkZ2zbq2biPEd4PHWlcytroAXlw5SMBUxZICCh9xKMGikfz5LbqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7260
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

cGxlYXNlIGlnbm9yZSwgd2lsbCBzZW5kIHYzDQo=
