Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F7204F7F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2020 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgFWKu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jun 2020 06:50:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:35851 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFWKu6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Jun 2020 06:50:58 -0400
IronPort-SDR: oh7EvBKTJREGen9Qy+vmfIhk2Wq+9ZDpiG4SvmK63a7+bGei6f1hykO75TqTxt5BZhQ3rH5kHd
 Rb3fimWj/Fgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="132433196"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="132433196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 03:49:54 -0700
IronPort-SDR: epA5csOOJlqkLy948I3GI39TyVzs3D6qeFvdJCqz+4CbB23lw5yazFdAxS8pBK86BUjJHNrqwR
 VXVLHJOysjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="263307181"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 03:49:53 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jun 2020 03:49:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jun 2020 03:49:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 23 Jun 2020 03:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B43EUOzb0LqyIasf60h/5YY5yl1zX5v4kpGtirJLpCB4DRY32jhUkqd5ylHiBb3G08yoavvO9M3ltngje9SeyIMTFkBt2ZSOLPgXM9hcAlWYCLVVA2q+oo3Z0DKcvLfb4Qv9ZxR1G/bwldjL87BiPcHe3WMLRljjIqbu3fS8YZONX2+THDWbsd7BNerppp4hMkVgW+OGAtRdmyBLu4Zhg575px0v6HaXJIrcyCH1r0z2Ow7NbTlyPvhueEX/US7VtaotxF+26GxZiVhRzntKdLLXZWfvcnrbPVZ0SNQ/rtGt4QZvL7mxtZDTaxGRHPbwhYbjk5gOPogaT28ik3KDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABf9fXL2+zynBLrX3ekG0yzgLbROKjCSodxeePkpY4I=;
 b=ZYHUhqkVw65ECnvr5Jjn3fQJ82q2coCLgt6seqAhGoVncE5j8Z2huTgOROlg6nR8Slv1I3kf9/r0dY/Sb5u4Z8UNT3f1J314v0cALH/v2puKlvulY3qK7LUV/vfj9M7gpk1/jkwBi7zWlgjKr1Gt6HdPzwTP8rehEdxTMj7rbqoBbWMqWA3U1f5AacQifTk9XnfpOoqtr8iaYSLlWrhIBxY9Wsr3rAqnwQAqCwy5VtavLK7k0LAnyy3I17Bt1bSE3E+/mgCoHyVcRN8cNmHjOc0jp8mlosyaE4lszVucSWNnfDPwlMDXlmxLPs6/KlSS9hx97jbs57rf2hlpC1TeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABf9fXL2+zynBLrX3ekG0yzgLbROKjCSodxeePkpY4I=;
 b=e4Mi6tiwjoxwvMScV/vjqdTgqiwxQ+Xu3xs90VyCLQ9s0SCUZ5PhKN1ZMInObNvdx6yKtntxqwsyFoQuWwvC0kSCU+AyLk+xCen9XkLT+ZN5yubrQVJv+PrM97oA2uVN+z21pqdwmWUqLR15Is11T/Q7//z0MiqlRuitKvGeT6E=
Received: from DM6PR11MB3227.namprd11.prod.outlook.com (2603:10b6:5:5d::16) by
 DM6PR11MB3898.namprd11.prod.outlook.com (2603:10b6:5:19f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Tue, 23 Jun 2020 10:49:51 +0000
Received: from DM6PR11MB3227.namprd11.prod.outlook.com
 ([fe80::414b:2619:c183:5662]) by DM6PR11MB3227.namprd11.prod.outlook.com
 ([fe80::414b:2619:c183:5662%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 10:49:51 +0000
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Topic: [PATCH v3 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Index: AQHWST/Uk+LV0SRSyEKwEgYsyXUp2ajl9Eow
Date:   Tue, 23 Jun 2020 10:49:51 +0000
Message-ID: <DM6PR11MB32272417362BFC730A04250DFE940@DM6PR11MB3227.namprd11.prod.outlook.com>
References: <cover.1592895906.git.mallikarjunax.reddy@linux.intel.com>
 <442bf3de3f5083cb6913dd4f51aee8ac5d9cbe71.1592895906.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <442bf3de3f5083cb6913dd4f51aee8ac5d9cbe71.1592895906.git.mallikarjunax.reddy@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [94.216.55.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34253ddf-0918-496d-cc37-08d81763282a
x-ms-traffictypediagnostic: DM6PR11MB3898:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3898C464A574D195E00787A3FE940@DM6PR11MB3898.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1gH5baaoMvcEpKptnqOfh+9YmoHFij4d5jk0vqpTRk/TLEdu0S6QA+Rf63rEnh1W9XmFCkEcs7QqjQRnVPD/F9XYat2WFo4HL0IDjCP7oiTUZCnYV+V24sXSzmkU5CgTQlkkd+PrHejtc8IPjohY72GuP1WOFcB6q7yf0xFUhylc67Uw2JTZTeGk3z9Im3j2v1gjCNA4GCwbKM7Ad+QezIEnx4K1/KhTmaNPFTt06h9IBnSCiuxTlh8HCJwR6ZOekU04oSHetPMiSV8nHuMdJTx4MlpzNeGR1cSltCh6m5DQHy2K1VuYBbhnsd9YwNRgWv1SgX7tuQ9hTjXQjgtDR+Z4plhrWkOHDRzVOmncmaU1OMXZb+2IVGqHGW99DCfDiKAh7hWgcGCyJtTR7sud3kX96t+0MuTMrHBlwEEXw7h9+TWazCRcagGFRsYm9wfxhGttu5QpUBDDE/gQ/rU0/l9iQy1bjmeyMo9HQ4olMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3227.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(55016002)(5660300002)(76116006)(54906003)(9686003)(30864003)(86362001)(66446008)(478600001)(66556008)(66476007)(71200400001)(316002)(64756008)(2906002)(52536014)(110136005)(66946007)(26005)(83380400001)(7696005)(186003)(8936002)(33656002)(6506007)(53546011)(8676002)(4326008)(966005)(473944003)(554374003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L1Z9rWPywq6epZ/009mMXKByoVpGG6YibzoSdbH5i67I1A6OTz6X2DSuPOuGQSJWRCcdSpxBYZgJgqKq41U8IZSCKs5KEVO/QUBBgGrz3mkEgaS9UlXbXP3/hFZygXBAnVTTY9l0kLTRKeO8SrjI0F4yPQZ/JgqxZvgUAHQs3tsdtuZJZ5ra+9TiAw9n86mpNGpvJS9ZFh0KV/skWXVC/oPMPByPt49mNCTkaonUecMSJuVDsg8HpeZugyTU+IY3XMsAtYQU1CDt7gJ1PSUJGd6KpWsAaDwe/V/XvdZIK7b5rmXb0ikASIwS9errWQWZMT/T+O2AZWk9toS6qeYKkqFLexMHMgM58/hvizH/168nvUB3eMDfzNloZijAlUFmv3OY3zKazsCNX2DbWh00xiEG5vQteJmWqW2e6SIa0eW3+33HszwYd6BdH/ABzpHHEihOLgEvGuiM4AsXC+QBKFSGGZtPm41+XQYlADh23N4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34253ddf-0918-496d-cc37-08d81763282a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 10:49:51.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzbnfMVD0I9cJy68+C5DNK1Cn0nyfz6SCs+C+kY2yfps3naEu7pbp/Z+70KxtIMZAP5DodJ0v9aommXUUf0gnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3898
X-OriginatorOrg: intel.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksDQoNCkkgaGF2ZSBzb21lIHF1ZXN0aW9ucyBhYm91dCB0aGUgYmluZGluZy4NClNvcnJ5IEkg
bWlzc2VkIHRvIGFzayBkdXJpbmcgaW50ZXJuYWwgcmV2aWV3LCBhcyBJIHdhcyBidXN5IHdpdGgg
b3RoZXIgdGFza3MgYXQgdGhhdCB0aW1lLg0KDQpTZWUgbXkgcXVlc3Rpb25zIGJlbG93Lg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRldmljZXRyZWUtb3duZXJAdmdl
ci5rZXJuZWwub3JnIDxkZXZpY2V0cmVlLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJl
aGFsZiBPZiBBbWlyZWRkeSBNYWxsaWthcmp1bmEgcmVkZHkNCj4gU2VudDogRGllbnN0YWcsIDIz
LiBKdW5pIDIwMjAgMTE6MjANCj4gVG86IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IHZrb3Vs
QGtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNoZXZjaGVua28sIEFu
ZHJpeQ0KPiA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgY2h1YW5odWEubGVpQGxpbnV4
LmludGVsLmNvbTsgS2ltLCBDaGVvbA0KPiBZb25nIDxjaGVvbC55b25nLmtpbUBpbnRlbC5jb20+
OyBXdSwgUWltaW5nIDxxaS1taW5nLnd1QGludGVsLmNvbT47DQo+IG1hbGxpYW1pcmVkZHkwMDlA
Z21haWwuY29tOyBBbWlyZWRkeSBNYWxsaWthcmp1bmEgcmVkZHkNCj4gPG1hbGxpa2FyanVuYXgu
cmVkZHlAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5k
aW5nczogZG1hOiBBZGQgYmluZGluZ3MgZm9yIGludGVsIExHTSBTT0MNCj4gDQo+IEFkZCBEVCBi
aW5kaW5ncyBZQU1MIHNjaGVtYSBmb3IgRE1BIGNvbnRyb2xsZXIgZHJpdmVyDQo+IG9mIExpZ2h0
bmluZyBNb3VudGFpbihMR00pIFNvQy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFtaXJlZGR5IE1h
bGxpa2FyanVuYSByZWRkeQ0KPiA8bWFsbGlrYXJqdW5heC5yZWRkeUBsaW51eC5pbnRlbC5jb20+
DQo+IC0tLQ0KPiB2MToNCj4gLSBJbml0aWFsIHZlcnNpb24uDQo+IA0KPiB2MjoNCj4gLSBGaXgg
Ym90IGVycm9ycy4NCj4gDQo+IHYzOg0KPiAtIE5vIGNoYW5nZS4NCj4gLS0tDQo+ICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9kbWEvaW50ZWwsbGRtYS55YW1sICAgICAgICB8IDQyOA0KPiArKysr
KysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MjggaW5zZXJ0aW9ucygrKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kbWEvaW50ZWwsbGRtYS55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9pbnRlbCxsZG1hLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ludGVsLGxkbWEueWFtbA0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ0NzRjM2U0NzEyNg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvaW50ZWws
bGRtYS55YW1sDQo+IEBAIC0wLDAgKzEsNDI4IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0t
DQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RtYS9pbnRlbCxsZG1hLnlh
bWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMNCj4gKw0KPiArdGl0bGU6IExpZ2h0bmluZyBNb3VudGFpbiBjZW50cmFsaXplZCBsb3cg
c3BlZWQgRE1BIGFuZCBoaWdoIHNwZWVkIERNQQ0KPiBjb250cm9sbGVycy4NCj4gKw0KPiArbWFp
bnRhaW5lcnM6DQo+ICsgIC0gY2h1YW5odWEubGVpQGludGVsLmNvbQ0KPiArICAtIG1hbGxpa2Fy
anVuYXgucmVkZHlAaW50ZWwuY29tDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgJG5vZGVuYW1l
Og0KPiArICAgcGF0dGVybjogIl5kbWEoQC4qKT8kIg0KDQpXaHkgaXMgdGhpcyBub3QgIl5kbWEt
Y29udHJvbGxlcihALiopPyQiIGFzIGluIHRoZSBjb21tb24gYmluZGluZz8NCg0KPiArDQo+ICsg
IiNkbWEtY2VsbHMiOg0KPiArICAgY29uc3Q6IDENCj4gKw0KPiArIGNvbXBhdGlibGU6DQo+ICsg
IGFueU9mOg0KPiArICAgLSBjb25zdDogaW50ZWwsbGdtLWNkbWENCj4gKyAgIC0gY29uc3Q6IGlu
dGVsLGxnbS1kbWEydHgNCj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS1kbWExcngNCj4gKyAgIC0g
Y29uc3Q6IGludGVsLGxnbS1kbWExdHgNCj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS1kbWEwdHgN
Cj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS1kbWEzDQo+ICsgICAtIGNvbnN0OiBpbnRlbCxsZ20t
dG9lX2RtYTMwDQo+ICsgICAtIGNvbnN0OiBpbnRlbCxsZ20tdG9lX2RtYTMxDQoNCldoeSBkbyB5
b3UgbmVlZCBzbyBtYW55IGRpZmZlcmVudCBjb21wYXRpYmxlIHN0cmluZ3M/DQpJIGFzc3VtZSB0
aGUgaHcgYmxvY2tzIGFyZSBtb3N0bHkgdGhlIHNhbWUsIHNvbWUgb2YgdGhlbSBsaW1pdGVkIHRv
IHJ4IG9yIHR4Lg0KV2h5IGlzIGl0IG5vdCBwb3NzaWJsZSB0byBkZXNjcmliZSB0aGF0IGFzIGFu
IGF0dHJpYnV0ZT8NCg0KQWxzbywgaXMgdGhlcmUgYSBkaWZmZXJlbmNlIGluIHRoZSB0b2VfZG1h
IGluc3RhbmNlcyAod2hpY2ggc2hvdWxkIG5vdCB1c2UgIl8iIGhlcmUhKT8NCk9yIGlzIGl0IG9u
bHkgdGhlIHdheSB0aGV5IGFyZSBjb25uZWN0ZWQgdG8gb3RoZXIgaHcgYmxvY2tzPyBJbiBjb2Rl
IHRoZXkgcmVmZXIgdGhlIHNhbWUgImhkbWFfb3BzIiBzdHJ1Y3QuDQoNCklmIHRoaXMgaXMgb25s
eSBhYm91dCBhIG5hbWUgdG8gYmUgcHJpbnRlZCBpbiB0aGUgZHJpdmVyLCBtYXliZSBhICJsYWJl
bCIgb3IgIm5hbWUiIGF0dHJpYnV0ZSB3aWxsIGJlIGFjY2VwdGVkPw0KDQo+ICsNCj4gKyByZWc6
DQo+ICsgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyBjbG9ja3M6DQo+ICsgIG1heEl0ZW1zOiAxDQo+
ICsNCj4gKyByZXNldHM6DQo+ICsgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyBpbnRlcnJ1cHRzOg0K
PiArICBtYXhJdGVtczogMQ0KPiArDQo+ICsgaW50ZWwsZG1hLXBvbGwtY250Og0KPiArICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCj4gKyAgIGRlc2NyaXB0
aW9uOg0KPiArICAgICBETUEgZGVzY3JpcHRvciBwb2xsaW5nIGNvdW50ZXIuIEl0IG1heSBuZWVk
IGZpbmUgdHVuZSBhY2NvcmRpbmcNCj4gKyAgICAgdG8gdGhlIHN5c3RlbSBhcHBsaWNhdGlvbiBz
Y2VuYXJpby4NCj4gKw0KPiArIGludGVsLGRtYS1ieXRlLWVuOg0KPiArICAgdHlwZTogYm9vbGVh
bg0KPiArICAgZGVzY3JpcHRpb246DQo+ICsgICAgIERNQSBieXRlIGVuYWJsZSBpcyBvbmx5IHZh
bGlkIGZvciBETUEgd3JpdGUoUlgpLg0KPiArICAgICBCeXRlIGVuYWJsZSgxKSBtZWFucyBETUEg
d3JpdGUgd2lsbCBiZSBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mDQo+IGR3b3Jkcw0KPiArICAgICBp
bnN0ZWFkIG9mIHRoZSB3aG9sZSBidXJzdC4NCj4gKw0KPiArIGludGVsLGRtYS1kcmI6DQo+ICsg
ICAgdHlwZTogYm9vbGVhbg0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgRE1BIGRlc2Ny
aXB0b3IgcmVhZCBiYWNrIHRvIG1ha2Ugc3VyZSBkYXRhIGFuZCBkZXNjDQo+IHN5bmNocm9uaXph
dGlvbi4NCj4gKw0KPiArIGludGVsLGRtYS1idXJzdDoNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAg
ICAgIFNwZWNpZml5IHRoZSBETUEgYnVyc3Qgc2l6ZShpbiBkd29yZHMpLCB0aGUgdmFsaWQgdmFs
dWUgd2lsbCBiZQ0KPiA4LCAxNiwgMzIuDQo+ICsgICAgICAgRGVmYXVsdCBpcyAxNiBmb3IgZGF0
YSBwYXRoIGRtYSwgMzIgaXMgZm9yIG1lbWNvcHkgRE1BLg0KPiArDQo+ICsgaW50ZWwsZG1hLXBv
bGxpbmctY250Og0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMv
dWludDMyDQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgRE1BIGRlc2NyaXB0b3IgcG9s
bGluZyBjb3VudGVyLiBJdCBtYXkgbmVlZCBmaW5lIHR1bmUgYWNjb3JkaW5nDQo+IHRvDQo+ICsg
ICAgICAgdGhlIHN5c3RlbSBhcHBsaWNhdGlvbiBzY2VuYXJpby4NCj4gKw0KPiArIGludGVsLGRt
YS1kZXNjLWluLXNyYW06DQo+ICsgICAgdHlwZTogYm9vbGVhbg0KPiArICAgIGRlc2NyaXB0aW9u
Og0KPiArICAgICAgIERNQSBkZXNjcml0cG9ycyBpbiBTUkFNIG9yIG5vdC4gU29tZSBvbGQgY29u
dHJvbGxlcnMgZGVzY3JpcHRvcnMNCj4gKyAgICAgICBjYW4gYmUgaW4gRFJBTSBvciBTUkFNLiBU
aGUgbmV3IG9uZXMgYXJlIGFsbCBpbiBTUkFNLg0KPiArDQo+ICsgaW50ZWwsZG1hLW9ycmM6DQo+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCj4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICBETUEgb3V0c3RhbmRpbmcgcmVhZCBjb3VudGVyLiBU
aGUgbWF4aW11bSB2YWx1ZSBpcyAxNiwgYW5kIGl0DQo+IG1heQ0KPiArICAgICAgIG5lZWQgZmlu
ZSB0dW5lIGFjY29yZGluZyB0byB0aGUgc3lzdGVtIGFwcGxpY2F0aW9uIHNjZW5hcmlvcy4NCj4g
Kw0KPiArIGludGVsLGRtYS10eGVuZGk6DQo+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCNkZWZpbml0aW9ucy91aW50MzINCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICBETUEg
VFggZW5kaWFubmVzcyBjb252ZXJzaW9uIGR1ZSB0byBTb0MgZW5kaWFubmVzcyBkaWZmZXJlbmNl
Lg0KDQpXaGF0IGRvZXMgdGhpcyBtZWFuPyBUaGUgU29DIGVuZGlhbm5lc3MgaXMga25vdyB0byB0
aGUgZHJpdmVyIGF0IGNvbXBpbGUgdGltZS4NCklzIGl0IHRoZSBkaWZmZXJlbmNlIG9mIHRoZSBk
ZXZpY2UgY29ubmVjdGVkIHRvIHRoZSBkbWE/DQpBcyBJIGtub3cgdGhlIGRtYSBpcyB1c2VkIGFs
c28gZm9yIFBDSWUgY29ubmVjdGVkIGRldmljZXMsIGhvdyBjYW4geW91IGRlZmluZSB0aGlzIGlu
IERUPw0KDQpTYW1lIGZvciBvdGhlciBhdHRyaWJ1dGVzIGJlbG93LiBJZiB0aGV5IGRlcGVuZCBv
biB0aGUgY29ubmVjdGVkIGRldmljZSwNCndoaWNoIGNhbiBiZSBleHRlcm5hbCB2aWEgUENJZSwg
aG93IGNhbiB5b3UgZGVmaW5lIHN0YXRpYyBjb25maWd1cmF0aW9uIHZhbHVlcyBpbiBEVCBmb3Ig
aXQ/DQoNCj4gKw0KPiArIGludGVsLGRtYS1yeGVuZGk6DQo+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAg
ICAgICBETUEgUlggZW5kaWFubmVzcyBjb252ZXJzaW9uIGR1ZSB0byBTb0MgZW5kaWFubmVzcyBk
aWZmZXJlbmNlLg0KPiArDQo+ICsgaW50ZWwsZG1hLWRidXJzdC13cjoNCj4gKyAgICB0eXBlOiBi
b29sZWFuDQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgRW5hYmxlIFJYIGR5bmFtaWMg
YnVyc3Qgd3JpdGUuIEl0IG9ubHkgYXBwbGllcyB0byBSWCBETUEgYW5kDQo+IG1lbWNvcHkgRE1B
Lg0KPiArDQo+ICsNCj4gKyBkbWEtcG9ydHM6DQo+ICsgICAgdHlwZTogb2JqZWN0DQo+ICsgICAg
ZGVzY3JpcHRpb246DQo+ICsgICAgICAgVGhpcyBzdWItbm9kZSBtdXN0IGNvbnRhaW4gYSBzdWIt
bm9kZSBmb3IgZWFjaCBETUEgcG9ydC4NCj4gKyAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgJyNh
ZGRyZXNzLWNlbGxzJzoNCj4gKyAgICAgICAgY29uc3Q6IDENCj4gKyAgICAgICcjc2l6ZS1jZWxs
cyc6DQo+ICsgICAgICAgIGNvbnN0OiAwDQo+ICsNCj4gKyAgICBwYXR0ZXJuUHJvcGVydGllczoN
Cj4gKyAgICAgICJeZG1hLXBvcnRzQFswLTldKyQiOg0KPiArICAgICAgICAgIHR5cGU6IG9iamVj
dA0KPiArDQo+ICsgICAgICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgICAgIHJlZzoNCj4g
KyAgICAgICAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgICAgICAgLSBlbnVtOiBbMCwgMSwg
MiwgMywgNCwgNV0NCj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAg
ICAgICAgIFdoaWNoIHBvcnQgdGhpcyBub2RlIHJlZmVycyB0by4NCj4gKw0KDQpTb21lIG9mIHRo
ZSBhdHRyaWJ1dGVzIGJlbG93IGhhdmUgInBvcnQtIiBpbiB0aGUgbmFtZS4NCkFzIHRoZXkgYXJl
IGluIHRoZSBub2RlIGZvciAiZG1hLXBvcnRzIiwgdGhpcyBpcyByZWR1bmRhbnQuDQoNCj4gKyAg
ICAgICAgICAgIGludGVsLHBvcnQtbmFtZToNCj4gKyAgICAgICAgICAgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy9zdHJpbmctYXJyYXkNCj4gKyAgICAgICAgICAgICAg
ZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIFBvcnQgbmFtZSBvZiBlYWNoIERNQSBw
b3J0Lg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxwb3J0LWNoYW5zOg0KPiArICAgICAgICAg
ICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkN
Cj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIFRoZSBj
aGFubmVscyBpbmNsdWRlZCBvbiB0aGlzIHBvcnQuIEZvcm1hdCBpcyBjaGFubmVsIHN0YXJ0DQo+
ICsgICAgICAgICAgICAgICAgIG51bWJlciBhbmQgaG93IG1hbnkgY2hhbm5lbHMgb24gdGhpcyBw
b3J0Lg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxwb3J0LWJ1cnN0Og0KPiArICAgICAgICAg
ICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gKyAg
ICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIFNwZWNpZnkgdGhl
IERNQSBwb3J0IGJ1cnN0IHNpemUsIHRoZSB2YWxpZCB2YWx1ZSB3aWxsIGJlDQo+ICsgICAgICAg
ICAgICAgICAgIDIsIDQsIDguIERlZmF1bHQgaXMgMiBmb3IgZGF0YSBwYXRoIGRtYS4NCj4gKw0K
PiArICAgICAgICAgICAgaW50ZWwscG9ydC10eHdndDoNCj4gKyAgICAgICAgICAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ICsgICAgICAgICAgICAg
IGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgICAgICAgICBTcGVjaWZ5IHRoZSBwb3J0IHRyYW5z
bWl0IHdlaWdodCBmb3IgUW9TIHB1cnBvc2UuIFRoZSB2YWxpZA0KPiArICAgICAgICAgICAgICAg
ICB2YWx1ZSBpcyAxfjcuIERlZmF1bHQgdmFsdWUgaXMgMS4NCj4gKw0KPiArICAgICAgICAgICAg
aW50ZWwscG9ydC1lbmRpYW46DQo+ICsgICAgICAgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgICAgICAgICAgICBkZXNjcmlwdGlvbjoN
Cj4gKyAgICAgICAgICAgICAgICAgU3BlY2lmeSB0aGUgRE1BIHBvcnQgZW5kaWFubmVzIGNvbnZl
cnNpb24gZHVlIHRvIFNvQyBlbmRpYW5uZXNzIGRpZmZlcmVuY2UuDQo+ICsNCj4gKyAgICAgICAg
ICByZXF1aXJlZDoNCj4gKyAgICAgICAgICAgIC0gcmVnDQo+ICsgICAgICAgICAgICAtIGludGVs
LHBvcnQtbmFtZQ0KPiArICAgICAgICAgICAgLSBpbnRlbCxwb3J0LWNoYW5zDQo+ICsNCj4gKw0K
PiArIGRtYS1jaGFubmVsczoNCj4gKyAgICB0eXBlOiBvYmplY3QNCj4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gKyAgICAgICBUaGlzIHN1Yi1ub2RlIG11c3QgY29udGFpbiBhIHN1Yi1ub2RlIGZvciBl
YWNoIERNQSBjaGFubmVsLg0KPiArICAgIHByb3BlcnRpZXM6DQo+ICsgICAgICAnI2FkZHJlc3Mt
Y2VsbHMnOg0KPiArICAgICAgICBjb25zdDogMQ0KPiArICAgICAgJyNzaXplLWNlbGxzJzoNCj4g
KyAgICAgICAgY29uc3Q6IDANCj4gKw0KPiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiArICAg
ICAgIl5kbWEtY2hhbm5lbHNAWzAtOV0rJCI6DQo+ICsgICAgICAgICAgdHlwZTogb2JqZWN0DQo+
ICsNCj4gKyAgICAgICAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgICAgICAgcmVnOg0KPiArICAg
ICAgICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAgICAgICAtIGVudW06IFswLCAxLCAyLCAz
LCA0LCA1LCA2LCA3LCA4LCA5LCAxMCwgMTEsIDEyLCAxMywgMTQsIDE1XQ0KPiArICAgICAgICAg
ICAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICAgICAgICAgV2hpY2ggY2hhbm5lbCB0aGlz
IG5vZGUgcmVmZXJzIHRvLg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxjaGFuLWRlc2NfbnVt
Og0KPiArICAgICAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAg
ICAgIFBlciBjaGFubmVsIG1heGltdW0gZGVzY3JpcHRvciBudW1iZXIuIFRoZSBtYXggdmFsdWUg
aXMgMjU1Lg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxjaGFuLXBrdF9zejoNCj4gKyAgICAg
ICAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+
ICsgICAgICAgICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgICAgICAgICBDaGFubmVs
IGJ1ZmZlciBwYWNrZXQgc2l6ZS4gSXQgbXVzdCBiZSBwb3dlciBvZiAyLg0KPiArICAgICAgICAg
ICAgICAgICBUaGUgbWF4aW11bSBzaXplIGlzIDQwOTYuDQo+ICsNCj4gKyAgICAgICAgICAgIGlu
dGVsLGNoYW4tZGVzYy1yeC1ub25wb3N0Og0KPiArICAgICAgICAgICAgICB0eXBlOiBib29sZWFu
DQo+ICsgICAgICAgICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgICAgICAgICBXcml0
ZSBub24tcG9zdGVkIHR5cGUgZm9yIERNQSBSWCBsYXN0IGRhdGEgYmVhdCBvZiBldmVyeSBkZXNj
cmlwdG9yLg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxjaGFuLWRhdGEtZW5kaWFuOg0KPiAr
ICAgICAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIFBl
ciBjaGFubmVsIGRhdGEgZW5kaWFubmVzcyBjb25maWd1cmF0aW9uIGFjY29yZGluZyB0byBTb0Mg
cmVxdWlyZW1lbnQuDQo+ICsNCj4gKyAgICAgICAgICAgIGludGVsLGNoYW4tZGVzYy1lbmRpYW46
DQo+ICsgICAgICAgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQzMg0KPiArICAgICAgICAgICAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICAgICAg
ICAgUGVyIGNoYW5uZWwgZGVzY3JpcHRvciBlbmRpYW5uZXNzIGNvbmZpZ3VyYXRpb24gYWNjb3Jk
aW5nIHRvIFNvQyByZXF1aXJlbWVudC4NCj4gKw0KPiArICAgICAgICAgICAgaW50ZWwsY2hhbi1k
YXRhLWVuZGlhbi1lbjoNCj4gKyAgICAgICAgICAgICAgdHlwZTogYm9vbGVhbg0KPiArICAgICAg
ICAgICAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICAgICAgICAgUGVyIGNoYW5uZWwgZGF0
YSBlbmRpYW5uZXNzIGVuYWJsZWQuDQo+ICsNCj4gKyAgICAgICAgICAgIGludGVsLGNoYW4tZGVz
Yy1lbmRpYW4tZW46DQo+ICsgICAgICAgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gKyAgICAgICAg
ICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIFBlciBjaGFubmVsIGRlc2Ny
aXB0b3IgZW5kaWFubmVzcyBlbmFibGVkLg0KPiArDQo+ICsgICAgICAgICAgICBpbnRlbCxjaGFu
LWJ5dGUtb2Zmc2V0Og0KPiArICAgICAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsg
ICAgICAgICAgICAgICAgIFBlciBjaGFubmVsIGJ5dGUgb2Zmc2V0KDB+MTI4KS4NCj4gKw0KPiAr
ICAgICAgICAgICAgaW50ZWwsY2hhbi1oZHItbW9kZToNCj4gKyAgICAgICAgICAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+ICsgICAgICAg
ICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgICAgICAgICAgICBUaGUgZmlyc3QgcGFyYW1l
dGVyIGlzIGhlYWRlciBtb2RlIHNpemUsIHRoZSBzZWNvbmQNCj4gKyAgICAgICAgICAgICAgICAg
cGFyYW1ldGVyIGlzIGNoZWNrc3VtIGVuYWJsZSBvciBkaXNhYmxlLiBJZiBlbmFibGVkLA0KPiAr
ICAgICAgICAgICAgICAgICBoZWFkZXIgbW9kZSBzaXplIGlzIGlnbm9yZWQuIElmIGRpc2FibGVk
LCBoZWFkZXIgbW9kZQ0KPiArICAgICAgICAgICAgICAgICBzaXplIG11c3QgYmUgcHJvdmlkZWQu
DQo+ICsNCj4gKyAgICAgICAgICAgIGludGVsLGNoYW4tbm9uLWFyYi1jbnQ6DQo+ICsgICAgICAg
ICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiAr
ICAgICAgICAgICAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgICAgICAgICAgICAgUGVyIGNoYW5u
ZWwgbm9uIGFyYml0cmF0aW9uIGNvdW50ZXIgd2hpbGUgcG9sbGluZw0KPiArDQo+ICsgICAgICAg
ICAgICBpbnRlbCxjaGFuLWFyYi1jbnQ6DQo+ICsgICAgICAgICAgICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgICAgICAgICAgICBkZXNjcmlw
dGlvbjoNCj4gKyAgICAgICAgICAgICAgICAgUGVyIGNoYW5uZWwgYXJiaXRyYXRpb24gY291bnRl
ciB3aGlsZSBwb2xsaW5nLg0KPiArICAgICAgICAgICAgICAgICBhcmJfY250IG11c3QgYmUgZ3Jl
YXRlciB0aGFuIG5vbl9hcmJfY250DQo+ICsNCj4gKyAgICAgICAgICAgIGludGVsLGNoYW4tcGt0
LWRyb3A6DQo+ICsgICAgICAgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gKyAgICAgICAgICAgICAg
ZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAgICAgICAgIENoYW5uZWwgcGFja2V0IGRyb3AgZW5h
YmxlZCBvciBkaXNhYmxlZC4NCj4gKw0KPiArICAgICAgICAgICAgaW50ZWwsY2hhbi1ody1kZXNj
Og0KPiArICAgICAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzItYXJyYXkNCj4gKyAgICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICAg
ICAgICAgICAgIFBlciBjaGFubmVsIGRtYSBoYXJkd2FyZSBkZXNjcmlwdG9yIGNvbmZpZ3VyYXRp
b24uDQo+ICsgICAgICAgICAgICAgICAgIFRoZSBmaXJzdCBwYXJhbWV0ZXIgaXMgZGVzY3JpcHRv
ciBwaHlzaWNhbCBhZGRyZXNzIGFuZCB0aGUNCj4gKyAgICAgICAgICAgICAgICAgc2Vjb25kIHBh
cmFtZXRlciBoYXJkd2FyZSBkZXNjcmlwdG9yIG51bWJlci4NCj4gKw0KPiArICAgICAgICAgIHJl
cXVpcmVkOg0KPiArICAgICAgICAgICAgLSByZWcNCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgLSBj
b21wYXRpYmxlDQo+ICsgLSByZWcNCj4gKyAtICcjZG1hLWNlbGxzJw0KPiArDQo+ICtleGFtcGxl
czoNCj4gKyAtIHwNCj4gKyAgIGRtYTA6IGRtYUBlMGUwMDAwMCB7DQo+ICsgICAgIGNvbXBhdGli
bGUgPSAiaW50ZWwsbGdtLWNkbWEiOw0KPiArICAgICByZWcgPSA8MHhlMGUwMDAwMCAweDEwMDA+
Ow0KPiArICAgICAjZG1hLWNlbGxzID0gPDE+Ow0KPiArICAgICBpbnRlcnJ1cHQtcGFyZW50ID0g
PCZpb2FwaWMxPjsNCj4gKyAgICAgaW50ZXJydXB0cyA9IDw4MiAxPjsNCj4gKyAgICAgcmVzZXRz
ID0gPCZyY3UwIDB4MzAgMD47DQo+ICsgICAgIHJlc2V0LW5hbWVzID0gImN0cmwiOw0KPiArICAg
ICBjbG9ja3MgPSA8JmNndTAgODA+Ow0KPiArICAgICBpbnRlbCxkbWEtcG9sbC1jbnQgPSA8ND47
DQo+ICsgICAgIGludGVsLGRtYS1ieXRlLWVuOw0KPiArICAgICBpbnRlbCxkbWEtZHJiOw0KPiAr
ICAgICBkbWEtcG9ydHMgew0KPiArICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArDQo+ICsgICAgICAgZG1hLXBvcnRzQDAgew0KPiAr
ICAgICAgICAgICByZWcgPSA8MD47DQo+ICsgICAgICAgICAgIGludGVsLHBvcnQtbmFtZSA9ICJT
UEkwIjsNCj4gKyAgICAgICAgICAgaW50ZWwscG9ydC1jaGFucyA9IDwwIDI+Ow0KPiArICAgICAg
ICAgICBpbnRlbCxwb3J0LWJ1cnN0ID0gPDI+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LXR4
d2d0ID0gPDE+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLXBvcnRzQDEgew0KPiArICAg
ICAgICAgICByZWcgPSA8MT47DQo+ICsgICAgICAgICAgIGludGVsLHBvcnQtbmFtZSA9ICJTUEkx
IjsNCj4gKyAgICAgICAgICAgaW50ZWwscG9ydC1jaGFucyA9IDwyIDI+Ow0KPiArICAgICAgICAg
ICBpbnRlbCxwb3J0LWJ1cnN0ID0gPDI+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LXR4d2d0
ID0gPDE+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLXBvcnRzQDIgew0KPiArICAgICAg
ICAgICByZWcgPSA8Mj47DQo+ICsgICAgICAgICAgIGludGVsLHBvcnQtbmFtZSA9ICJTUEkyIjsN
Cj4gKyAgICAgICAgICAgaW50ZWwscG9ydC1jaGFucyA9IDw0IDI+Ow0KPiArICAgICAgICAgICBp
bnRlbCxwb3J0LWJ1cnN0ID0gPDI+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LXR4d2d0ID0g
PDE+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLXBvcnRzQDMgew0KPiArICAgICAgICAg
ICByZWcgPSA8Mz47DQo+ICsgICAgICAgICAgIGludGVsLHBvcnQtbmFtZSA9ICJTUEkzIjsNCj4g
KyAgICAgICAgICAgaW50ZWwscG9ydC1jaGFucyA9IDw2IDI+Ow0KPiArICAgICAgICAgICBpbnRl
bCxwb3J0LWJ1cnN0ID0gPDI+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LWVuZGlhbiA9IDww
PjsNCj4gKyAgICAgICAgICAgaW50ZWwscG9ydC10eHdndCA9IDwxPjsNCj4gKyAgICAgICB9Ow0K
PiArICAgICAgIGRtYS1wb3J0c0A0IHsNCj4gKyAgICAgICAgICAgcmVnID0gPDQ+Ow0KPiArICAg
ICAgICAgICBpbnRlbCxwb3J0LW5hbWUgPSAiSFNOQU5EIjsNCj4gKyAgICAgICAgICAgaW50ZWws
cG9ydC1jaGFucyA9IDw4IDI+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LWJ1cnN0ID0gPDg+
Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LXR4d2d0ID0gPDE+Ow0KPiArICAgICAgIH07DQo+
ICsgICAgICAgZG1hLXBvcnRzQDUgew0KPiArICAgICAgICAgICByZWcgPSA8NT47DQo+ICsgICAg
ICAgICAgIGludGVsLHBvcnQtbmFtZSA9ICJQQ00iOw0KPiArICAgICAgICAgICBpbnRlbCxwb3J0
LWNoYW5zID0gPDEwIDY+Ow0KPiArICAgICAgICAgICBpbnRlbCxwb3J0LWJ1cnN0ID0gPDg+Ow0K
PiArICAgICAgICAgICBpbnRlbCxwb3J0LXR4d2d0ID0gPDE+Ow0KPiArICAgICAgIH07DQo+ICsg
ICAgIH07DQo+ICsgICAgIGRtYS1jaGFubmVscyB7DQo+ICsgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ICsgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsNCj4gKyAgICAgICBkbWEt
Y2hhbm5lbHNAMCB7DQo+ICsgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgaW50
ZWwsY2hhbi1kZXNjX251bSA9IDwxPjsNCj4gKyAgICAgICB9Ow0KPiArICAgICAgIGRtYS1jaGFu
bmVsc0AxIHsNCj4gKyAgICAgICAgICAgcmVnID0gPDE+Ow0KPiArICAgICAgICAgICBpbnRlbCxj
aGFuLWRlc2NfbnVtID0gPDE+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLWNoYW5uZWxz
QDIgew0KPiArICAgICAgICAgICByZWcgPSA8Mj47DQo+ICsgICAgICAgICAgIGludGVsLGNoYW4t
ZGVzY19udW0gPSA8MT47DQo+ICsgICAgICAgfTsNCj4gKyAgICAgICBkbWEtY2hhbm5lbHNAMyB7
DQo+ICsgICAgICAgICAgIHJlZyA9IDwzPjsNCj4gKyAgICAgICAgICAgaW50ZWwsY2hhbi1kZXNj
X251bSA9IDwxPjsNCj4gKyAgICAgICB9Ow0KPiArICAgICAgIGRtYS1jaGFubmVsc0A0IHsNCj4g
KyAgICAgICAgICAgcmVnID0gPDQ+Ow0KPiArICAgICAgICAgICBpbnRlbCxjaGFuLWRlc2NfbnVt
ID0gPDE+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLWNoYW5uZWxzQDUgew0KPiArICAg
ICAgICAgICByZWcgPSA8NT47DQo+ICsgICAgICAgICAgIGludGVsLGNoYW4tZGVzY19udW0gPSA8
MT47DQo+ICsgICAgICAgfTsNCj4gKyAgICAgICBkbWEtY2hhbm5lbHNANiB7DQo+ICsgICAgICAg
ICAgIHJlZyA9IDw2PjsNCj4gKyAgICAgICAgICAgaW50ZWwsY2hhbi1kZXNjX251bSA9IDwxPjsN
Cj4gKyAgICAgICB9Ow0KPiArICAgICAgIGRtYS1jaGFubmVsc0A3IHsNCj4gKyAgICAgICAgICAg
cmVnID0gPDc+Ow0KPiArICAgICAgICAgICBpbnRlbCxjaGFuLWRlc2NfbnVtID0gPDE+Ow0KPiAr
ICAgICAgIH07DQo+ICsgICAgICAgZG1hLWNoYW5uZWxzQDggew0KPiArICAgICAgICAgICByZWcg
PSA8OD47DQo+ICsgICAgICAgfTsNCj4gKyAgICAgICBkbWEtY2hhbm5lbHNAOSB7DQo+ICsgICAg
ICAgICAgIHJlZyA9IDw5PjsNCj4gKyAgICAgICB9Ow0KPiArICAgICAgIGRtYS1jaGFubmVsc0Ax
MCB7DQo+ICsgICAgICAgICAgIHJlZyA9IDwxMD47DQo+ICsgICAgICAgfTsNCj4gKyAgICAgICBk
bWEtY2hhbm5lbHNAMTEgew0KPiArICAgICAgICAgICByZWcgPSA8MTE+Ow0KPiArICAgICAgIH07
DQo+ICsgICAgICAgZG1hLWNoYW5uZWxzQDEyIHsNCj4gKyAgICAgICAgICAgcmVnID0gPDEyPjsN
Cj4gKyAgICAgICB9Ow0KPiArICAgICAgIGRtYS1jaGFubmVsc0AxMyB7DQo+ICsgICAgICAgICAg
IHJlZyA9IDwxMz47DQo+ICsgICAgICAgfTsNCj4gKyAgICAgICBkbWEtY2hhbm5lbHNAMTQgew0K
PiArICAgICAgICAgICByZWcgPSA8MTQ+Ow0KPiArICAgICAgIH07DQo+ICsgICAgICAgZG1hLWNo
YW5uZWxzQDE1IHsNCj4gKyAgICAgICAgICAgcmVnID0gPDE1PjsNCj4gKyAgICAgICB9Ow0KPiAr
ICAgICB9Ow0KPiArICAgfTsNCj4gKyAtIHwNCj4gKyAgIGRtYTM6IGRtYUBlYzgwMDAwMCB7DQo+
ICsgICAgIGNvbXBhdGlibGUgPSAiaW50ZWwsbGdtLWRtYTMiOw0KPiArICAgICByZWcgPSA8MHhl
YzgwMDAwMCAweDEwMDA+Ow0KPiArICAgICBjbG9ja3MgPSA8JmNndTAgNzE+Ow0KPiArICAgICBy
ZXNldHMgPSA8JnJjdTAgMHgxMCA5PjsNCj4gKyAgICAgI2RtYS1jZWxscyA9IDwxPjsNCj4gKyAg
ICAgaW50ZWwsZG1hLWJ1cnN0ID0gPDMyPjsNCj4gKyAgICAgaW50ZWwsZG1hLXBvbGxpbmctY250
ID0gPDE2PjsNCj4gKyAgICAgaW50ZWwsZG1hLWRlc2MtaW4tc3JhbTsNCj4gKyAgICAgaW50ZWws
ZG1hLW9ycmMgPSA8MTY+Ow0KPiArICAgICBpbnRlbCxkbWEtYnl0ZS1lbjsNCj4gKyAgICAgaW50
ZWwsZG1hLXR4ZW5kaSA9IDwwPjsNCj4gKyAgICAgaW50ZWwsZG1hLXJ4ZW5kaSA9IDwwPjsNCj4g
KyAgICAgaW50ZWwsZG1hLWRidXJzdC13cjsNCj4gKyAgICAgZG1hLWNoYW5uZWxzIHsNCj4gKyAg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MD47DQo+ICsNCj4gKyAgICAgICAgIGRtYS1jaGFubmVsc0AxMiB7DQo+ICsgICAgICAgICAgICAg
cmVnID0gPDEyPjsNCj4gKyAgICAgICAgICAgICBpbnRlbCxjaGFuLXBrdF9zeiA9IDw0MDk2PjsN
Cj4gKyAgICAgICAgICAgICBpbnRlbCxjaGFuLWRlc2Mtcngtbm9ucG9zdDsNCj4gKyAgICAgICAg
ICAgICBpbnRlbCxjaGFuLWRhdGEtZW5kaWFuID0gPDA+Ow0KPiArICAgICAgICAgICAgIGludGVs
LGNoYW4tZGVzYy1lbmRpYW4gPSA8MD47DQo+ICsgICAgICAgICAgICAgaW50ZWwsY2hhbi1kYXRh
LWVuZGlhbi1lbjsNCj4gKyAgICAgICAgICAgICBpbnRlbCxjaGFuLWRlc2MtZW5kaWFuLWVuOw0K
PiArICAgICAgICAgICAgIGludGVsLGNoYW4tYnl0ZS1vZmZzZXQgPSA8MD47DQo+ICsgICAgICAg
ICAgICAgaW50ZWwsY2hhbi1oZHItbW9kZSA9IDwxMjggMD47DQo+ICsgICAgICAgICAgICAgaW50
ZWwsY2hhbi1ub24tYXJiLWNudCA9IDwwPjsNCj4gKyAgICAgICAgICAgICBpbnRlbCxjaGFuLWFy
Yi1jbnQgPSA8MD47DQo+ICsgICAgICAgICAgICAgaW50ZWwsY2hhbi1ody1kZXNjID0gPDB4MjAw
MDAwMDAgOD47DQo+ICsgICAgICAgICB9Ow0KPiArICAgICAgICAgZG1hLWNoYW5uZWxzQDEzIHsN
Cj4gKyAgICAgICAgICAgICByZWcgPSA8MTM+Ow0KPiArICAgICAgICAgICAgIGludGVsLGNoYW4t
cGt0LWRyb3A7DQo+ICsgICAgICAgICAgICAgaW50ZWwsY2hhbi1wa3Rfc3ogPSA8NDA5Nj47DQo+
ICsgICAgICAgICAgICAgaW50ZWwsY2hhbi1kYXRhLWVuZGlhbiA9IDwwPjsNCj4gKyAgICAgICAg
ICAgICBpbnRlbCxjaGFuLWRlc2MtZW5kaWFuID0gPDA+Ow0KPiArICAgICAgICAgICAgIGludGVs
LGNoYW4tZGF0YS1lbmRpYW4tZW47DQo+ICsgICAgICAgICAgICAgaW50ZWwsY2hhbi1kZXNjLWVu
ZGlhbi1lbjsNCj4gKyAgICAgICAgICAgICBpbnRlbCxjaGFuLWJ5dGUtb2Zmc2V0ID0gPDA+Ow0K
PiArICAgICAgICAgICAgIGludGVsLGNoYW4taGRyLW1vZGUgPSA8MTI4IDA+Ow0KPiArICAgICAg
ICAgICAgIGludGVsLGNoYW4tbm9uLWFyYi1jbnQgPSA8MD47DQo+ICsgICAgICAgICAgICAgaW50
ZWwsY2hhbi1hcmItY250ID0gPDA+Ow0KPiArICAgICAgICAgfTsNCj4gKyAgICAgfTsNCj4gKyAg
IH07DQo+IC0tDQo+IDIuMTEuMA0KDQo=
