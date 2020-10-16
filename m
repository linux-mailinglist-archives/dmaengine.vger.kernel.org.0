Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6902028FE77
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 08:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgJPGpy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 02:45:54 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:6686 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389811AbgJPGpy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 02:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602830753; x=1634366753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W5lU+9e+ztBfi8lzwkfe8HRfrf+cfCw/E8MwcU34CVM=;
  b=xdIt+S7c4OdhYm8EEEJZml2gif2PcqLYJ4fmdXewgM0rXyJrZvxR6mfB
   tg7/1PH1eHx5CRm3/mey5lFFZmMsBoC07z/YqlAo0saFIBKRT4+TFfPX1
   yDzKPvh1TcbsrlazoL0GAuet4E0q8gX/G+hC1A0+5JikUIvOOZX7VPO/m
   kY10C0Y23m8rclOc+yzjXmsfzsyqmTfwTf1wal92iESOlJEuU/dL8ODtf
   ytBAqsHuSoFOb65+PyXWXZCemE9VFrlYsW+zT3n1iZMZfFAss8pTwc8kB
   5BGGW/V50HvgliH/a0078dZs1VrCCXOMwml2q6QvnmwUtA2bG9Ja4mXty
   w==;
IronPort-SDR: j4iUqcZaLEKqig/KBcWvrFj8dgbWw9wAlRi8guIwIfdm7FVByZWv+yAjnv1uKU+jH78E6N+NZy
 zTF0CYPU4GYwojhZtcca6V9I4K9gw619aVpZdmvL54D8Wnmh2F7qFjbpWos8LTocXJaz/kf6AF
 XAZaJZeQbYzk01ygolM3omxTI/XZ4C2AxiSDVxXNqL2K8jtg40p562jhwZ6bnE1YDAMOn4RWUE
 WxgRcFu1Hi49GIDxx0FVr+duOs2Z0P9tB+2FNh6yoqENsUW9Yn7l6XWmf4w872xL9XpkMvmxED
 FuQ=
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="99771762"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2020 23:45:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 15 Oct 2020 23:45:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 15 Oct 2020 23:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW2axHc7Dkyi0ueCkbQhheqkha6wp2re9kWI/JHZkAT+aaMNDRa6AAj549+H0XmI+ww1bAN0eDQlr3dz7jI1KYZs7KXP8lpwPX2D/nIGDohn4pSI1j1/FRyh3tKOWJZrpgGxNiRCqlF734HN3pYk2ek8kn+B7pV5ZGzIxW75XPfAMMQhob3U5WUI5cimxaOa4g2U7QwlFnW6KVO8TAnGIH31mKQrg9xONp3/rYnr+xHORlFZd5SQhUBR+alsgPOXv4x4a5Ui6IPvZXutltBng38HE/yrfPF6+5nB65bXwRmIViJikFu9bnL2A0qQImbN/DrmenrR67hp/m/9/zh0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5lU+9e+ztBfi8lzwkfe8HRfrf+cfCw/E8MwcU34CVM=;
 b=S6IzxOAEpLycnN1/1L/hPXOf2+EflgrMN/doQcdGajDKjd3ZQLEg8wkKcmbOKmJZfQMeOqmx0H8p5qqvQTRSCeYtvaLu04y026o9UHpcTGCLKtEUOLqBszinFZL3ofvMrAD9oIvWf3OzWHNBrQNiqL741+cYgG/l0IIT9PJRMA4bXLUrQ2IblQz0B0dOS7k8y6GCHr6yMrQoK0o1trbDR9J/ohCqh7Ng6D4JOAyvBHs9rc1y+U6rY3ED+CbhTHoCHeQzqFrxIumozIyth9X6d3c8++mP3JbZ5In+EQjTaVMLEB75tbBUEr8kiuAxayN3LrN6lqVF25BzmHpwsoO/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5lU+9e+ztBfi8lzwkfe8HRfrf+cfCw/E8MwcU34CVM=;
 b=YWtbBQKMLMbK3vZKCQEyyRSU/Qhze30NqEUl1KP8NL0r9XZ4DSJF2m687zHD3DP7zGXl4njnLr7GHbOkhd/ITu4rg/nsiLfEh+lUG+eGv8YugjUDPE6uFGwQVYi3gyN2VEpEqYWgjMl8RoTTYAijVUODCH5++B6O1pBaZtivaks=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BYAPR11MB2757.namprd11.prod.outlook.com (2603:10b6:a02:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 06:45:52 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51%7]) with mapi id 15.20.3455.030; Fri, 16 Oct 2020
 06:45:51 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh@kernel.org>
CC:     <vkoul@kernel.org>, <Tudor.Ambarus@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Thread-Topic: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Thread-Index: AQHWiqDp9DiavjeRmUuCFfDHAe+8HKl1XEiAgCSebgA=
Date:   Fri, 16 Oct 2020 06:45:51 +0000
Message-ID: <6f305564-e91c-794b-0025-de805f1d1a58@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-7-eugen.hristev@microchip.com>
 <20200922233327.GA3474555@bogus>
In-Reply-To: <20200922233327.GA3474555@bogus>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [188.27.154.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5ae4626-c002-4acd-3e0f-08d8719f1fb1
x-ms-traffictypediagnostic: BYAPR11MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27571946FECA1C8907FAD637E8030@BYAPR11MB2757.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwmD9ftyszttW18NdCM2YwyRu5FQwimluGpSVQRFTn8yTtZ4tRL3n+hnkYMIXrvEII85rnqGmUJD3xT06FXKjwh25FxABEG/I9dKn08LstBP1r4uvazIodTxvy/oG/cVKfFQFUnUxF00lbWn1eeR1MoCejeMwMGgnqjJAFb7OfjtZxWJIeMMK6dKwdiHS4U7FFwuTbI0udUNSE9FNw4hexKh0IILBrONAJjUpRAqDVo2TKGPxAV4s6LYWY1eDyTnuWYCw0cdmdQUDS/vfSBkjIDVS2dZBaqaGEKvlwfTXKiDwsYUtz6v/jDw8HnRpJ7YuGwVizy1liDOwSE5xJpBITBjC4jg9LBJp/aY7FwiYJ6WHxIYF4hZ7fLWvHmEb6ca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(36756003)(31696002)(31686004)(6512007)(54906003)(107886003)(71200400001)(4326008)(478600001)(316002)(83380400001)(64756008)(66946007)(66556008)(76116006)(86362001)(8936002)(26005)(66446008)(66476007)(8676002)(91956017)(5660300002)(6486002)(6916009)(2906002)(186003)(6506007)(53546011)(2616005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uR3H8yI1FGBX2tB4IYfzMWSYNCJM9vUa2XYt6rlWIBRLfC3ZhBgdymLe4RIYbWFiZz43il7hUTJxXWJnPGr6NJ36Hds+ZQGDJsG7pfrW1PvRmP49+IUDigVd5y4e6V4Gojr4BT08AtBrLfwvMh6iBZpGz5ypCUW7CyIc6iqMRuEOP7t9PtkQlbNtQY1R+OaIpm/rI1XhSYhs1Jxo6P4bjjTtQ9fUzezOLPZw57bUXvIVcwQNSuIqgzaed2aUOKwWvWFHtNU7BxCgfp3wzU+3eCxS8CB1M2IHGqe+vl+xuXqu/fctrIStXyRd/APwF7c+yTHMI7TArWDR9NAlVGSqDAGmesRqg+Zblg29xfPO5hSYxkEvMvV/T6m/v0df8HNTh/R2aYt55JkVWcWkULfkBXv5M1xsEALW/GFIvYDzSf4D5n/MJtYe52v4mbP+fsmVEcbytzEUI5TViyuOEhmH1D5AXoNsAo2uABO3i/Kpq+ucZpy5irFz23MLxvlQMA6F0xVT601pb1MhBFUKs1rs4EHFjIcuO8Dp0QGqSl/IZiGMEz13q45w49AsO68p8i4dO3OSb1WUMtRGp50iFaw48hDazUIBvMeWCSCFRsf6yL7vyTdHCovT3E/Idi+nnO73KwmYgfteJ+t5lhufLpTqyg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CCCBF602F215C40A9F573ABB5A52A97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae4626-c002-4acd-3e0f-08d8719f1fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 06:45:51.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhwm4soe8C45ovuAQgmXUxsDVmRmqqZTTrzbBHvz/ystY8aJT/Yaq09ZNVxax6fDxI202l3gAY5/Y0Y3IeeGJEnQYdVKtDSpPGNjmakBOEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2757
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjMuMDkuMjAyMCAwMjozMywgUm9iIEhlcnJpbmcgd3JvdGU6DQoNCj4gT24gTW9uLCBTZXAg
MTQsIDIwMjAgYXQgMDU6MDk6NTVQTSArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4+IEFk
ZCBvcHRpb25hbCBtaWNyb2NoaXAsbTJtIHByb3BlcnR5IHRoYXQgc3BlY2lmaWVzIGlmIGEgY29u
dHJvbGxlciBpcw0KPj4gZGVkaWNhdGVkIHRvIG1lbW9yeSB0byBtZW1vcnkgb3BlcmF0aW9ucyBv
bmx5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZG1hL2F0bWVsLXhkbWEudHh0IHwgNiArKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2F0bWVsLXhkbWEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2RtYS9hdG1lbC14ZG1hLnR4dA0KPj4gaW5kZXggNTEwYjdmMjViYTI0Li42
NDJkYTZiOTVhMjkgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZG1hL2F0bWVsLXhkbWEudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZG1hL2F0bWVsLXhkbWEudHh0DQo+PiBAQCAtMTUsNiArMTUsMTIgQEAgdGhl
IGRtYXMgcHJvcGVydHkgb2YgY2xpZW50IGRldmljZXMuDQo+PiAgICAgICBpbnRlcmZhY2UgaWRl
bnRpZmllciwNCj4+ICAgICAgIC0gYml0IDMwLTI0OiBQRVJJRCwgcGVyaXBoZXJhbCBpZGVudGlm
aWVyLg0KPj4NCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gKy0gbWljcm9jaGlwLG0ybTog
dGhpcyBjb250cm9sbGVyIGlzIGNvbm5lY3RlZCBvbiBBWEkgb25seSB0byBtZW1vcnkgYW5kIGl0
J3MNCj4+ICsgICAgIGRlZGljYXRlZCB0byBtZW1vcnkgdG8gbWVtb3J5IERNQSBvcGVyYXRpb25z
LiBJZiB0aGlzIG9wdGlvbiBpcw0KPj4gKyAgICAgbWlzc2luZywgaXQncyBhc3N1bWVkIHRoYXQg
dGhlIERNQSBjb250cm9sbGVyIGlzIGNvbm5lY3RlZCB0bw0KPj4gKyAgICAgcGVyaXBoZXJhbHMs
IHRodXMgaXQncyBhIHBlcjJtZW0gYW5kIG1lbTJwZXIuDQo+IA0KPiBXb3VsZG4ndCAnZG1hLXJl
cXVlc3RzID0gPDA+JyBjb3ZlciB0aGlzIGNhc2U/DQo+IA0KPiBSb2INCj4gDQoNCkhpIFJvYiwN
Cg0KSSBkbyBub3QgdGhpbmsgc28uIFdpdGggcmVxdWVzdHMgPSAwLCBpdCBtZWFucyB0aGF0IGFj
dHVhbGx5IHRoZSBETUEgDQpjb250cm9sbGVyIGlzIHVudXNhYmxlID8NClNpbmNlIHlvdSBzdWdn
ZXN0IHJlcXVlc3RzID0gMCwgaXQgbWVhbnMgdGhhdCBpdCBjYW5ub3QgdGFrZSByZXF1ZXN0cyBh
dCANCmFsbCA/DQpJIGRvIG5vdCBmaW5kIGFub3RoZXIgZXhhbXBsZSBpbiBjdXJyZW50IERUIHdp
dGggdGhpcyBwcm9wZXJ0eSBzZXQgdG8gemVyby4NCg0KRXVnZW4NCg0K
