Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A47AB018
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjIVK73 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIVK71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 06:59:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13F4AC;
        Fri, 22 Sep 2023 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695380361; x=1726916361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LFTTb2csT2/oxPQIWJiI+BzhxkY5mdQfT2FKiyOMZmQ=;
  b=rz7+0g9Pnml27rDb6ffwz3L6a9XtefP0zK4YLlN+5Ebtpbdd135VASI5
   EOclhD9xpc3iNo3iA9gxBn23nrFPxnXM1SSVz9k4BwwfzlAoIUzKMqe7D
   8D4fFEa5WxNg7YgG+MFsgPFFH38xx3iPMrQiBJQroIblbdFSeGEXW67Gl
   7WPrCUAeAur9NnwUxpuOPJKp6siCmRdfJ71q31Wg+EBpi9lTDQcrnHcD4
   1cUFhzuOqOlwttqidKSxPBw+wWChqqE5PG42TSdzVsIjhEf/copjtPzUx
   5HGEd9YrYMHekWMabsWs/4AIk41r3l1lbIlDTkL9kn0cJ4z0nQeruG8a7
   g==;
X-CSE-ConnectionGUID: bd7qvu6HQ76RalQG4Zn3uA==
X-CSE-MsgGUID: 4YfelX45SM2Ll/wH0kSjVA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="6060332"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2023 03:59:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 22 Sep 2023 03:59:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 22 Sep 2023 03:59:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWZV4708WkmPb/1oCiAf3x7afUCUPc6FhpHvnE/EBOFsa8/+b4jCEPw2iIcbaX5poI/Y64rUOfO4Kd03bBVB9vDNPQE6rpb8B0Xaz2kRfSaTKTDe3UD/Fk7jvdAe/TwWbMTamxa28GqllGNR4EAwTnNHsmDyh6vSNFVYNjP+hsGE3GFgXrei/P/qsGZN1sMnDFT8dTxAdv49LVTaZa58FFJj/KEizIxDc2B1rGIoeuuJhE0il3zDghUsN+SZ+ZJ9yL5woadeTv7to7+EVAGjOMEoYw50c+5DQoKuQfDKrdTuK0wgXRZRVdbmcI7pUblg1r0wuBeDpwIaiuGAVe5lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFTTb2csT2/oxPQIWJiI+BzhxkY5mdQfT2FKiyOMZmQ=;
 b=UtMnuoo8S4HhqnnKLzNi+j6Z7z69c6/UZpepy0HhCov6oZaWZX7z4UmNiCqdZ4iHnl7D0+7r0xFakqV9XxchR9jeMY0SZ19N3uNRm0Dfqca6hG09WDsUrC9DZrAJ6b8ZuaVrmMmUx2FdZTUtDQRRhnyttiq7zy9lX/uYkg2X0yFtOftGuJ5imQUy/wp1/+4gBhnlTlyVq5JYPsO7rzL2ru+KKCBGI5OfHn9QpOpIXb/UdlfGNY76aAMJ/EkhNHRFjwdHhnNJbogLrMaMCZ8wqntna8P8WjagSaz2G8DgxAipK2Qg+qXP0fCTetLRw92TtWMCL39lXbynl8hON9695A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFTTb2csT2/oxPQIWJiI+BzhxkY5mdQfT2FKiyOMZmQ=;
 b=pRWMGn8O2vrZtovdScfGTqJVoFfpR/UHL6dBjhY3mZv3UrPnS4Mz+h4KhR7TDNLij2y4Pg4oXBUy2lxp4HA4mxl/DPEDQ43XdC5e6+LrxKAcTZUhCFdzWjVT7TiQdsCIyqR0TWRSLiCWvNr94zX9ZUvp/alPFO7qr4dXe3GHwpo=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:59:04 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 10:59:04 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <emil.renner.berthing@canonical.com>, <green.wan@sifive.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
        <palmer@sifive.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>
Subject: RE: [PATCH v1 1/3] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Thread-Topic: [PATCH v1 1/3] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Thread-Index: AQHZ7To1s/07Ob6QNEaD2mS2IRA+F7AmqX+AgAADPTA=
Date:   Fri, 22 Sep 2023 10:59:04 +0000
Message-ID: <PH0PR11MB561162E58DA1E7F11E60DBB381FFA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230922095039.74878-1-shravan.chippa@microchip.com>
 <20230922095039.74878-2-shravan.chippa@microchip.com>
 <CAJM55Z-NUwzo9SKtmV_5OegznDjSQEG9DVK7=5x4qnxUkk399A@mail.gmail.com>
In-Reply-To: <CAJM55Z-NUwzo9SKtmV_5OegznDjSQEG9DVK7=5x4qnxUkk399A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|DS0PR11MB7804:EE_
x-ms-office365-filtering-correlation-id: b03de551-cd5e-42cb-963a-08dbbb5aef68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XadyD9VR31HyA2FLIc9t+AZUspFdhNlhNeOk9dzRxJRETYPh+WRTkMByjJkSCWsSptRptDNN+K4+XGBuje3gkKUWulrtQA8OAM5ROC4bHMJFYKK2BonLDfVc1N2H0UpF4HA2nfSoIeOmI+J84iIYe2MfNflsTUSeeMUZmlb6wCi6gT4hD4m/W/ru3L1bUWoaDHshDjkYXKOo28Im9hdxOu6rn3hM12wV+lQx7mRh49CW+uyL+vhzW9WTzF/V0+s0ngsSh1UhrcLj7/uW+SsVRRbZYuPWLSxKw+qOh99pnOhbNFx3p80oRfWcZ28AGk2QOQWbqcvlgaTdXhqPBOLwto3/Mspw6zyA1twZNrOt4NecnH9xuZFYD/1Un2jm9q7uSOeEqwRU7PloU4uU2pjZBMknLCRETbgLg1tkNClTQA1QU1wAjV94Gb2qTijJ92o9PG4UmXJs/2tFWkI0+VzrEY7KMwfApC7bp/pjDx4tW0pqwxT8Q/e/h9Q+VA4IBM4EvWWfaDIvR0G6vrNKV15EGr/aI0TsI1YJ700loPNRZ3xDBNTpxg8LGMJaGxiG6W3suDSXRqrx3WP+sLo84/VAWjHt/PyjDT7xVr59auejwRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(41300700001)(38100700002)(5660300002)(107886003)(2906002)(55016003)(26005)(122000001)(33656002)(38070700005)(7416002)(4326008)(86362001)(8676002)(83380400001)(478600001)(53546011)(9686003)(8936002)(6506007)(966005)(7696005)(52536014)(316002)(76116006)(110136005)(71200400001)(66446008)(64756008)(54906003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTUvcUcxNEFpYUtQbFp4eWszYk9yNVdObWJZL3VSNDRCOXlURmR3V3ZpVGhj?=
 =?utf-8?B?VmFwMnl2ZllEMklvUWhDejMreGpuT2Judlh4TnpYRlZYZVNFSWFvNHJIbk5z?=
 =?utf-8?B?VFBQMndhNWtNazR3SXBBSDNLYlZWWTEwbHRnejdCQnA2eWJvQTF6SGxtSDd1?=
 =?utf-8?B?MUpOVksvQzJiVlFJSXRyM05yZ0J2cFdwaWgyN3MxOUNRK1RQcEwvbTR5UjRj?=
 =?utf-8?B?T0NFalp0a1hieG1OamVuR2hYRFBuVW9KU3I4L1dwcjdIRFQ5TWpWM0dMVG9n?=
 =?utf-8?B?Mk5jZWdLRDQ5ZThFNDZjekFocnJLMkVXK3Zucmt0cUhQa2lTSnRjcU0zUVl4?=
 =?utf-8?B?dURsNWQ3cnFMd054VEFRVS9RTFdiaG5QY3NMMVQ1TXpoZUN4dVI1ZHZ3Kzkw?=
 =?utf-8?B?bTd2SmJpRkExODdwaWlUTytITzhBRG83OFhJbzZvSHhYY1N6Y1NMdzJ0WVZ1?=
 =?utf-8?B?NUR2dWxNVzFidjhEV1FzNjFhZ2d2VjlQQzNIaml1eXhOcjRrT3RueVNLVDBW?=
 =?utf-8?B?SGtMcTRSUzl2Mm40bjJ5M0xpYTREQVhzUVhiWW51YnVSemwvRmluTVJiSlo0?=
 =?utf-8?B?RU9EdW9pRExVOU8wZGFnMStmODRzYm5hTWMzNUZmVDY5V0xMQmRSVjYxbXo3?=
 =?utf-8?B?c0RjeXVXbEEwTW5sM2EyQ1RxeGxUWjYxN2hMTFl0YndIZ0RmaElOV3VtMEZv?=
 =?utf-8?B?aWY5SktBRnp6UUh0N29Rc3hTUkhmZzhkSkI2aEdTYWc0Wmc4MVIzU2Zmb203?=
 =?utf-8?B?WitYSUIvbUE1T0tMSTYyakVkcENtSktBQThHUUJDQzh3ODdjUm1UYXNMN2p1?=
 =?utf-8?B?bDhQT01Tc2JxbnpBbDFrZ0QrcEw1dDREY2FFbFRSNzNBSzhmanAzR3VCWlky?=
 =?utf-8?B?blJZSDBNckxka0kxWlRFcWRYUUN5SlA1TUg5MDljWm13V2pnUkN5WmdOVzlm?=
 =?utf-8?B?U2hRYTJvYjVSRko5T0VlNVF4VHY4YUJJRVNDOW5wTURMakFJTTEveVl5aUVY?=
 =?utf-8?B?ZjVZanlPMjE4bTkvcnVJTnd2bHJtS1JhamJEOXB3ZnB6ZlFQV0hDSkdVMkx4?=
 =?utf-8?B?MzdnS01xSGdIaEpjSDZjQTNKWU5HUzd4ODRLNkwxQ25aTnR6U1IyaERMc2JR?=
 =?utf-8?B?U0M2SzhQMlZGSStCWTEydy9CaTIyOFl5QUNhWk5KNUF0M3N0R1F5VDZSd25S?=
 =?utf-8?B?OXBUWlo2TzZKUnBIWmx0UU1QbU5INEwxZEdSL0YxTzd3QXBMT2xjM1JUQ2VO?=
 =?utf-8?B?dEhPc1M1bnlCWXBzeWVSamhrWHZDOFk3N3hXRUhpV0pvUko5U3hkQUo5VGVC?=
 =?utf-8?B?SUFoNTFwSlloc2M2THdycStxUDdmMUdwN3YraUdtOWhlM3RtMGlNNW4rYmtJ?=
 =?utf-8?B?c0JFdnJSUHM4dmFYUnc0bG5hMUZJWkh4N3FVMjJ6YTJSQXNuT1pTN0pkckNk?=
 =?utf-8?B?eHJYS3NDak9ib3VMb2NOZjA1MEZkNkRGd0JFSFhuTHo1U04ySHVqdnVqMXQw?=
 =?utf-8?B?NUVKaVVXMW9hcEtnc2R4bUhkWDhrcVN3SlpDRWF0M1VFU0tCT3VRMlVlQXIw?=
 =?utf-8?B?a0JTSXBpY1JQelZRb1dOR1FOdlEvVXVwMHhnaG9UZE91Rm56T2lQbEFsaGVa?=
 =?utf-8?B?UkxEVTFPWHJXUGx1bk9NSFVac3dycU9YRTVHSnRyWDdqRU5IbWVocGtncGxS?=
 =?utf-8?B?dHpXUGN1eWpQenlBb2JRRGZoUC9GcjFESFFTcjVnWlQ4Y0JtT2FHdjd1M0JI?=
 =?utf-8?B?TDhMV2g4c1ZwbmpZamtnTFF1bHk3ZUk3dzQ5ZDNpOU5meXl5T3krVEtSQlZk?=
 =?utf-8?B?aVI3TTgvMFFDaTNNcnlKTU5nS3NaRUFEMXhEUUdiVTF0VnBCbEZYaVZtcTRU?=
 =?utf-8?B?cHZOVXllOHRKb05FbmtuRGxjYmdnTFhWYWJDWXZ5SmhvQ0xRY3dGYTlncW16?=
 =?utf-8?B?dmdmUTZKd2FCZVZ1T1IwSWZpUHk2M1FpZVlBZm5teEJFUmZXaHdTL1RrZk9H?=
 =?utf-8?B?dzh6aEVEQnkrWjNHbmlmNG5EVE4ySXVMeDRRU0llZEs3VWdjTHN4UTFuSWN6?=
 =?utf-8?B?QlJJd3F1YnhIN2ZSMEpKUGtaalI2QmhpLzdmQ3VYWVVWMnpyMlJwejFrditT?=
 =?utf-8?B?cVpSd2xsejlPS1M3YXZYRGh3ZW1YK2k0RktXMEVhYjYrZlFxSzJ3WnBwYmlG?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03de551-cd5e-42cb-963a-08dbbb5aef68
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 10:59:04.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VkCnUIYMxrr54HiaQpqt5axLVJ5L9GPAe94aXetpI6MForXEoMcBPO6JTagQ8k5laEr9/rqB1lLW+9RZV/ujBkUs88ZgCsWq2Ue38oD/Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW1pbCBSZW5uZXIgQmVy
dGhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDIyLCAyMDIzIDQ6MTYgUE0NCj4gVG86IHNocmF2YW4gQ2hpcHBhIC0gSTM1
MDg4IDxTaHJhdmFuLkNoaXBwYUBtaWNyb2NoaXAuY29tPjsNCj4gZ3JlZW4ud2FuQHNpZml2ZS5j
b207IHZrb3VsQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+IHBhdWwud2FsbXNs
ZXlAc2lmaXZlLmNvbTsgY29ub3IrZHRAa2VybmVsLm9yZzsgcGFsbWVyQHNpZml2ZS5jb20NCj4g
Q2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTmFnYXN1cmVzaCBSZWxsaSAtDQo+IEk2NzIwOCA8TmFnYXN1cmVzaC5SZWxs
aUBtaWNyb2NoaXAuY29tPjsgUHJhdmVlbiBLdW1hciAtIEkzMDcxOA0KPiA8UHJhdmVlbi5LdW1h
ckBtaWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10gZG1hZW5naW5l
OiBzZi1wZG1hOiBTdXBwb3J0DQo+IG9mX2RtYV9jb250cm9sbGVyX3JlZ2lzdGVyKCkNCj4gDQo+
IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fu
b25pY2FsLmNvbS4gTGVhcm4NCj4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IHNocmF2YW4gY2hpcHBhIHdyb3RlOg0KPiA+
IEZyb206IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+
DQo+ID4gVXBkYXRlIHNmLXBkbWEgZHJpdmVyIHRvIGFkb3B0IGdlbmVyaWMgRE1BIGRldmljZSB0
cmVlIGJpbmRpbmdzLg0KPiA+IEl0IGNhbGxzIG9mX2RtYV9jb250cm9sbGVyX3JlZ2lzdGVyKCkg
d2l0aCBzZi1wZG1hIHNwZWNpZmljDQo+ID4gb2ZfZG1hX3hsYXRlIHRvIGdldCB0aGUgZ2VuZXJp
YyBETUEgZGV2aWNlIHRyZWUgaGVscGVyIHN1cHBvcnQgYW5kIHRoZQ0KPiA+IERNQSBjbGllbnRz
IGNhbiBsb29rIHVwIHRoZSBzZi1wZG1hIGNvbnRyb2xsZXIgdXNpbmcgc3RhbmRhcmQgQVBJcy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBt
aWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEu
YyB8IDQxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuYw0KPiA+IGIvZHJpdmVycy9kbWEvc2YtcGRtYS9zZi1w
ZG1hLmMgaW5kZXggZDFjNjk1NmFmNDUyLi5jNzU1OGM5ZjlhYzMNCj4gPiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1h
L3NmLXBkbWEvc2YtcGRtYS5jDQo+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBp
bmcuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9v
Zl9kbWEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPg0KPiA+ICAjaW5jbHVk
ZSAic2YtcGRtYS5oIg0KPiA+IEBAIC00OTAsNiArNDkxLDMzIEBAIHN0YXRpYyB2b2lkIHNmX3Bk
bWFfc2V0dXBfY2hhbnMoc3RydWN0IHNmX3BkbWENCj4gKnBkbWEpDQo+ID4gICAgICAgfQ0KPiA+
ICB9DQo+ID4NCj4gPiArc3RhdGljIHN0cnVjdCBkbWFfY2hhbiAqc2ZfcGRtYV9vZl94bGF0ZShz
dHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzDQo+ICpkbWFfc3BlYywNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgb2ZfZG1hICpvZmRtYSkgew0KPiA+ICsgICAg
IHN0cnVjdCBzZl9wZG1hICpwZG1hID0gb2ZkbWEtPm9mX2RtYV9kYXRhOw0KPiA+ICsgICAgIHN0
cnVjdCBkZXZpY2UgKmRldiA9IHBkbWEtPmRtYV9kZXYuZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCBz
Zl9wZG1hX2NoYW4gICpjaGFuOw0KPiA+ICsgICAgIHN0cnVjdCBkbWFfY2hhbiAqYzsNCj4gPiAr
ICAgICB1MzIgY2hhbm5lbF9pZDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGRtYV9zcGVjLT5hcmdz
X2NvdW50ICE9IDEpIHsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQmFkIG51bWJl
ciBvZiBjZWxsc1xuIik7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgIGNoYW5uZWxfaWQgPSBkbWFfc3BlYy0+YXJnc1swXTsNCj4g
PiArDQo+ID4gKyAgICAgY2hhbiA9ICZwZG1hLT5jaGFuc1tjaGFubmVsX2lkXTsNCj4gPiArDQo+
ID4gKyAgICAgYyA9IGRtYV9nZXRfc2xhdmVfY2hhbm5lbCgmY2hhbi0+dmNoYW4uY2hhbik7DQo+
ID4gKyAgICAgaWYgKCFjKSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIk5vIG1v
cmUgY2hhbm5lbHMgYXZhaWxhYmxlXG4iKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBOVUxM
Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIGM7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIHN0YXRpYyBpbnQgc2ZfcGRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KSAgew0KPiA+ICAgICAgIHN0cnVjdCBzZl9wZG1hICpwZG1hOw0KPiA+IEBAIC01NjMsNyAr
NTkxLDIwIEBAIHN0YXRpYyBpbnQgc2ZfcGRtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICB9DQo+
ID4NCj4gPiArICAgICByZXQgPSBvZl9kbWFfY29udHJvbGxlcl9yZWdpc3RlcihwZGV2LT5kZXYu
b2Zfbm9kZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZl9w
ZG1hX29mX3hsYXRlLCBwZG1hKTsNCj4gPiArICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAg
ICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAi
Q2FuJ3QgcmVnaXN0ZXIgU2lGaXZlIFBsYXRmb3JtIE9GX0RNQS4gKCVkKVxuIiwgcmV0KTsNCj4g
PiArICAgICAgICAgICAgIGdvdG8gZXJyX3VucmVnaXN0ZXI7DQo+ID4gKyAgICAgfQ0KPiA+ICsN
Cj4gDQo+IEhpIFNocml2YW4sDQo+IA0KPiBEb2Vzbid0IHRoaXMgbmVlZCBhIG1hdGNoaW5nIHVu
cmVnaXN0ZXIvZnJlZSBjYWxsIGluIHRoZSBzZl9wZG1hX3JlbW92ZQ0KPiBmdW5jdGlvbj8NCj4g
DQo+IC9FbWlsDQo+IA0KDQpXaWxsIGFkZCBvZl9kbWFfY29udHJvbGxlcl9mcmVlKG5wKSBjYWxs
IGluIHRoZSBzZl9wZG1hX3JlbW92ZSgpLg0KDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gKw0K
PiA+ICtlcnJfdW5yZWdpc3RlcjoNCj4gPiArICAgICBkbWFfYXN5bmNfZGV2aWNlX3VucmVnaXN0
ZXIoJnBkbWEtPmRtYV9kZXYpOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9
DQo+ID4NCj4gPiAgc3RhdGljIGludCBzZl9wZG1hX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPiA+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgtcmlzY3YgbWFp
bGluZyBsaXN0DQo+ID4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg==
