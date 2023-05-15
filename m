Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC1703C75
	for <lists+dmaengine@lfdr.de>; Mon, 15 May 2023 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbjEOST7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 14:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbjEOSTC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 14:19:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5138659B;
        Mon, 15 May 2023 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684174700; x=1715710700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CiGrWggfBiELbMO2FtkAe/Dp/pGOmdWLMmLBqP5akxY=;
  b=wlhzgGzuV0B7jrsdISA3jIHNqJljRnqvOcFVDMMuasvNBDYjhi5TG8E6
   OpGQb19frV7shf7q+q70gASA3RPE91gD4i7dMGrZOhYhyYAjARoNfkU0K
   uMAb/cTEhaM19whN+QlirHIbXuQbC7ULDwB6VMytqJQa2lnJMdqsU+JhB
   //GfTHSefXgxoRVpPEADRkj18k2Hy8ghVG+sYFi3taQ/DD6bIaH9+rA93
   qZk13FRdDhqAGN4SMw4WCxakDyyUYueoir/qgT0R4eamfSfcvJzwmgUAx
   gvrOKoB/FMxmPUcZA6dWgVAziVZVmxZLJN3eEnrf+j2VvI2PpdECVkHM1
   A==;
X-IronPort-AV: E=Sophos;i="5.99,277,1677567600"; 
   d="scan'208";a="215491583"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 11:18:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 11:18:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 15 May 2023 11:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMoerssvHzFljx8LfpYjaMw7mSWG68LWIfAThGoLfO+UFd21m+a8X0RI/FrJgb7uZjpwo2t0ZGYXQwWA/SYx/hauYKqaOsEjlxyFrCmB3tFauG4lrjzpgcoq+gRCmVYh/03u94J80pEKIFdtgh0IYmv0DWgK91j91KvWoPOJ9mQlTotUydCQk5CMfQmYs1UYETQIrfeNY7IYPeiVoozO1by9WfIRqTKMS4V3wyeklHrlNUCfXmkW9eRdDIsjCBhaE4xCWZQw/11ikg9jx9Iq4VpV6fWjknjTZUubF2qunfP1yM1ddHzmNVKEKCPoMMblflh9uuuGFVu1dy6lR3HmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiGrWggfBiELbMO2FtkAe/Dp/pGOmdWLMmLBqP5akxY=;
 b=UxJfY4MeIzwHwfq+V6UHVj2lB4O7J2r75wozrRx64WSAeFIw8uviU9U6+XG2uT2kUUhvYsTO4unqM4hRmGjBgOy9/umEQg7fd1EVgCOwLg7UAk110Ka7Dfy13uL6pzHEL1QgJCfZW5n9dqkNUzo7G7MElEnZl/eC9Veu9H6NGnfJX1hOXhRDO2D8uQN9Wq8ZvL50AMg83F/J+g4+Ym4ttQJe7aA00e1Ul900+cs/Q4SJ/Cre7NWFWEwKhR1om+YZIZwzIDJaEwINsX2FZD7faw6zrzHZjLWSJUe1HEgADKZKc6txP80xkbZamkqDmPAmziYul83wtFc8XWvzJuCNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiGrWggfBiELbMO2FtkAe/Dp/pGOmdWLMmLBqP5akxY=;
 b=Eh8ljf/BpwSLV5Kel8yWIHW5kuOasOMN3gPNd0vFEjfd8yNt8j15p3iRP2B3eHbdY5yC9ZJVQDBEVw9ohKjx7pITRxQrDECH9ejUdENn8pdNPyLfDGc9UqP1xkIk6wqgnTAQA3hUvbV7EvQebYAQeX0JJYRW4Lm2/cZDaA6wlvQ=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by PH7PR11MB8010.namprd11.prod.outlook.com (2603:10b6:510:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Mon, 15 May
 2023 18:18:07 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:18:07 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <tglx@linutronix.de>,
        <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZdjYbp7JofHpSCkG4OMYCy0fppa9IJWMAgAK/9wCAEK3nAIAAM4SA
Date:   Mon, 15 May 2023 18:18:07 +0000
Message-ID: <0ee5aa616475cc39b04c6b9e84db119bc8fc4d53.camel@microchip.com>
References: <20230423213717.318655-1-kelvin.cao@microchip.com>
         <20230423213717.318655-2-kelvin.cao@microchip.com>
         <ZFH/xhyjm9VTZolE@infradead.org>
         <50e111a3cfecd0f232508d1b03e02d1e25d9d4a9.camel@microchip.com>
         <ZGJMKFrLfU2zc/2P@infradead.org>
In-Reply-To: <ZGJMKFrLfU2zc/2P@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|PH7PR11MB8010:EE_
x-ms-office365-filtering-correlation-id: fe9d3abd-d88f-4bce-62e8-08db5570bbc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKtrKGgRjIjx0bNh0BuJWIeKaQRQJT3RBYrcHI1dCaIOuaV7SZRpY18H5ZVyW1zvzdZS2yOSQFVEWsQ7kIPYhsO1dbMIO9dobaSrUgUovxvVWf9NI97FbbOj0uOPD2EO3m9pIAYeAn4Q8GB1cCRVlO9AtoRZUnjUmUzyh6o8p0tsj6CkNs7Sz6jjms8JPCltXN+p+Cam/W8jaPJ138xzRwGnvALIsrg6NedlMrTbXGprfeT2+BJOuWUHLL/HRi2/DqBXyo0MZIt/ylLOB+9K0HQMAnwxMu5KfxhGZV1iict7CLLX1mEZp9u4MIRjbEIVkUX7IaPRUQLQkLaXs1TzOXSUwUzhBMX0fEV+6kOCPJ8DH0koNRuol3t6zbVM6owhI3TrNJRC2ePqsu8mby3OKJfIj4pc7sqbBkU4Oxl2qeWCldnLo7yJhmhqkI5OVGQtqOAkHvDokj9Xs1w7xszK7s1piJ3uuDJHtrqsntmy0JOHC+WsZ2eskHo5vMEBFHks9cLcqRnpwWQBbXlIp0ywFIfIjKitZXEd1FII1/8KSBGEu170k0AxIqswfH8zQYUW5tebOxkjN5Su0gIqi/jJVZ1TOUdSHFgqQxjGjUJEum66oVMNRoV0lJNSV9+VCPiU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(26005)(186003)(6512007)(6506007)(41300700001)(38100700002)(71200400001)(6486002)(2616005)(478600001)(54906003)(6916009)(66446008)(4326008)(66556008)(91956017)(64756008)(122000001)(76116006)(66946007)(66476007)(5660300002)(36756003)(316002)(8936002)(8676002)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWtWb3RZU0tCQTdLbDFROU4yOW04RWdHK3NMdVF1S25vY01haEpRU25RVEZa?=
 =?utf-8?B?Ly90ekVKVm5nc282VG9FY0RQWmtObFNVZ0ZaRWpVOWhsTnNzV3pZQm9DTUNz?=
 =?utf-8?B?NUQ2NGlYRVJqdmhvZnZVUlJObGd6ZUF4cDVuUGw5SkVtOFRlUUliemhYRTZt?=
 =?utf-8?B?YzFLR2tLYU5pbWR3Q0NEYVhVb1kzdldScXBOL0tOc2V6WHVPUmEzZUZrWUl3?=
 =?utf-8?B?UURLcmtkRER4MWlGaS9oZFU0ZEo1bW4zZXNYWlVhcVdmSlZjb2tzYmRQcnV4?=
 =?utf-8?B?azQvaGQ1UlpBQ3NpbkhaRS8xY2Zsc255b0RNRGh1ZkdvdmVDL2dVZUUwMFRv?=
 =?utf-8?B?aG9DWVlwb21wZ1Zyak5VVmdDK0c5NFFjMVZtZ0VyUitFUEE4MjlTUHRWSEdq?=
 =?utf-8?B?VjA5b3dSYzM5WGZBMnJHR0tic1ZFNXJyMUNsdW56TGZRQXdJUEY4N0NNSG9o?=
 =?utf-8?B?QnFjSFM5N2FrT1RtbHc4TmlVODBGdFNOY1VCcEg4Rm0rdll0THlXazlkdW5I?=
 =?utf-8?B?TDR4dUJYeTROMmRBYUhaUVZYcUhRRXJMYkpid3RvWWNsQTh0bTMvYVZZY2x6?=
 =?utf-8?B?OWc4NXFLMlRkZWV6VGtFcnc5Q1FhYTdHTVFvdy80M2FLSGFUekdLR1hMQnJI?=
 =?utf-8?B?bzBvN01yK0RNTnJVRUo5QkFTYll0Y2cxc2pvcmVRVlBBY0ZKak9BeHRyQThN?=
 =?utf-8?B?dXJnTFlNNXRaQ0t3ZEpWdmZWRFp2VnIzOEw4K2F2STFRbEE1dDBLa1B0VU9l?=
 =?utf-8?B?RXE4V3RBVXFDSlh2NzAzVXJoTWxlaWRKdDMyMGhMS3k5YVAvZ1hqcWtNMVhI?=
 =?utf-8?B?MGpJd3pORnJDTGZXbUJRMmJSMVRNbVJLcEZLYW5FdVh2RCtkb0hWVzcweE5u?=
 =?utf-8?B?clA5VFZWazlmcEVuSE0wb0hFMGFhaFJaT2ZKMmVlMTZMYTJtbFROTHk5QkJ6?=
 =?utf-8?B?ZkVEZGtScHJCbzAvT2FoTG5VMTVyQVhaN3VSOHdCQ01uTWl5U3NUbFRuVjZQ?=
 =?utf-8?B?VFpZeU4weEhJOThocXRxTzVjcExIa281eXVVdGJFbUFicHNKQ05WSzhNajM3?=
 =?utf-8?B?VUw0eFludUdYNmpGdWhSTXpJK3dod3ZmOHZXNzdUR2ttVnVhRUQ3a2NMT2U1?=
 =?utf-8?B?MDl6MVdzUTZ1MjlMQVJGK0xtZ0d5M2VXbGg3Qmtic21WNEpFd0dVa1hCTzQ0?=
 =?utf-8?B?b0JlTzdrYUVWUHpxaGRsY2UyUk5zUkdWSkpLeWRSZ0hpN1lyNVdaQjk0cTN1?=
 =?utf-8?B?KzZDcUVBT3dLSmpRZWNmL1FwclgwbDJvcEtWcVlDTlhRVFl4SURPY28ra3Yz?=
 =?utf-8?B?VklLTW42aEhBVE1Oc3pSdFJIV1BhN3BtSjc1WHVnQkExZ2x4TDE2MHRNTXZa?=
 =?utf-8?B?NVZaWUFSQ2dkZnAzczhZa0RmMDdWWXJVYXdZSnYwWmt4ci8ySkFTUXB6RW9K?=
 =?utf-8?B?MTNyNnZtU29ITkNBczFEaHR0d013VlBXQ2FPR0V3cTU3WU1qaEF0V2haQTNO?=
 =?utf-8?B?Z2J0dHBtM3NaWFVQa3hNaGNHYnpVbWlwT3N3dmhMVnVBdjAzNnkzazdwR2RG?=
 =?utf-8?B?Q3ZrM3lsekk1d2p5RUpCbFhJZkVqNnFMeEwrS3VjbHI5SnRBZW9SclFLa0hX?=
 =?utf-8?B?T2hkY3NKcWJxNjg2aFdXRTlhT3RlcFY4YnBQaks5eW1DeHNCLzg1a3NvWXoy?=
 =?utf-8?B?Y3FEUEZUNnFSajdsb3pwSkxjR0FXUzRwTE5VRkpVdXlsSmIwMCttTy9SRk13?=
 =?utf-8?B?TmQwa05DUTdlTE9LYlRWc3JLeDkxVk9tQ1hyZ0hPeWNXSTFpc29pYnpFRW9H?=
 =?utf-8?B?SithNUwrakN2cTNUTDcwSW1xMHdZcDZ5MTg1cG91VEdyQzAwRjRUR013RXAz?=
 =?utf-8?B?N25tWlFhVDh5RGxpRW8rSzVPa2lLWkhqMzJLODE5dFd5eUdySmlWc0s2d000?=
 =?utf-8?B?VXFMMmdCUUNDT0wvVi8vaVI2bzVhbHc2Wm1teWRzMmcvRGV6cER5YkpYN0ZB?=
 =?utf-8?B?Wm1OemgwWUtsRGVXWUFUZWdnZlg1UGdvblZsZmdMNjdJNnk1ZEFob2dvOEE1?=
 =?utf-8?B?NS91b1FGUTFlTU1WNnNpdGpydkZlTzRES1EyYlU1S090eFNQRlhsSU1DVW5V?=
 =?utf-8?B?RDVUdEcvZmdSd2VrYU1VL2hYeVQwUGZESm8wbGt6VHQ3UzhlVnRtaUwxZlZN?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DEE69A93CA26D4191177BC0B6240929@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d3abd-d88f-4bce-62e8-08db5570bbc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 18:18:07.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh/Nzln6C1PH7dLz5ygJ/tGyuG1XePL5ryTeGzXk8lj/DzKfVGJ0HT1d8wVEG39LuqH3TR9ZkeHwk29njMrCPJgObeAruUHob5CXEtwx7co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDA4OjEzIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gDQo+ID4gPiA+ICvCoMKgwqDCoCB1bmlvbiB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgX19sZTMyIHNhZGRyX2xvOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9fbGUzMiB3aWRhdGFfbG87DQo+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiAr
wqDCoMKgwqAgdW5pb24gew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fbGUz
MiBzYWRkcl9oaTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2xlMzIgd2lk
YXRhX2hpOw0KPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+IA0KPiA+ID4gV2hhdCBpcyB0aGUg
cG9pbnQgZm9yIHVuaW9ucyBvZiBpZGVudGljYWwgZGF0YSB0eXBlcz8NCj4gPiANCj4gPiBUaGUg
c2FtZSBvZmZzZXQgY291bGQgaG9sZCBlaXRoZXIgc291cmNlIGFkZHJlc3Mgb3Igd3JpdGUgaW1t
ZWRpYXRlDQo+ID4gZGF0YSBpbiBkaWZmZXJlbnQgdHJhbnNhY3Rpb25zLiBVbmlvbnMgdXNlZCBo
ZXJlIGlzIHRvIGdpdmUNCj4gPiBkaWZmZXJlbnQNCj4gPiBuYW1lcyBmb3IgdGhlIHNhbWUgb2Zm
c2V0LiBJIGd1ZXNzIGl0IGltcHJvdmVzIHJlYWRhYmlsaXR5IHdoZW4NCj4gPiByZWZlcnJpbmcg
dG8gdGhlbSB3aXRoIHByb3BlciBuYW1lcy4NCj4gDQo+IEkgZmluZCB0aGlzIHJhdGhlciBjb25m
dXNpbmcsIGVzcGVjaWFsbHkgYXMgc29tZSBjb2RlIGxpdGVyYWxseQ0KPiBzd2l0Y2hlcyBvbiB0
aGUgb3AgdG8gZmlsbCBpbiBlaXRoZXIgc2V0Lg0KDQpJdCdzIGEgaGFyZHdhcmUgaW50ZXJmYWNl
LCBhbmQgbm90IHBvc3NpYmxlIHRvIGNoYW5nZSBpdCBhdCB0aGUgcG9pbnQuDQpJIGd1ZXNzIEkg
Y2FuIG1ha2UgaXQgbG9vayBzbGlnaHRseSBiZXR0ZXIgYnkgZ3JvdXBpbmcgdGhlIHJlbGF0ZWQN
Cm5hbWVzIHRvZ2V0aGVyOg0KDQp1bmlvbiB7DQogICAgICAgIHN0cnVjdCB7DQogICAgICAgICAg
ICAgICAgX19sZTMyIHNhZGRyX2xvOw0KICAgICAgICAgICAgICAgIF9fbGUzMiBzYWRkcl9oaTsN
CiAgICAgICAgfTsNCiAgICAgICAgc3RydWN0IHsNCiAgICAgICAgICAgICAgICBfX2xlMzIgd2lk
YXRhX2xvOw0KICAgICAgICAgICAgICAgIF9fbGUzMiB3aWRhdGFfaGk7DQogICAgICAgIH07DQp9
Ow0KPiANCj4gDQo+ID4gPiA+ICsjZGVmaW5lIFNXSVRDSFRFQ19ETUFfREVWSUNFKGRldmljZV9p
ZCkgXA0KPiA+ID4gPiArwqDCoMKgwqAgeyBcDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLnZlbmRvcsKgwqDCoMKgID0gUENJX1ZFTkRPUl9JRF9NSUNST1NFTUksIFwNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZGV2aWNlwqDCoMKgwqAgPSBkZXZpY2VfaWQs
IFwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc3VidmVuZG9ywqAgPSBQQ0lf
QU5ZX0lELCBcDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnN1YmRldmljZcKg
ID0gUENJX0FOWV9JRCwgXA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5jbGFz
c8KgwqDCoMKgwqAgPSBQQ0lfQ0xBU1NfU1lTVEVNX09USEVSIDw8IDgsIFwNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuY2xhc3NfbWFzayA9IDB4RkZGRkZGRkYsIFwNCj4gPiA+
ID4gK8KgwqDCoMKgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkIHN3aXRjaHRlY19kbWFfcGNpX3RibFtdID0gew0KPiA+ID4gPiArwqDCoMKg
wqAgU1dJVENIVEVDX0RNQV9ERVZJQ0UoMHg0MDAwKSwgLyogUEZYIDEwMFhHNCAqLw0KPiA+ID4g
DQo+ID4gPiBUaGlzIHNob3VsZCB1c2UgdGhlIGNvbW1vbiBQQ0lfREVWSUNFKCkgbWFjcm8gaW5z
dGVhZCwgaS5lLg0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfTUlDUk9TRU1JLCAweDQwMDApLCAvKiBQRlgNCj4gPiA+IDEwMFhHNCAqLw0KPiA+
ID4gwqDCoMKgwqDCoMKgwqAgLi4uDQo+ID4gDQo+ID4gV2UgYWxzbyBuZWVkIHRvIGRpc3Rpbmd1
aXNoIHRoZSAuY2xhc3MgYXMgd2UgaGF2ZSBkZXZpY2VzIG9mIG90aGVyDQo+ID4gLmNsYXNzIHdp
dGggdGhlIHNhbWUgdmVuZG9yL2RldmljZSBJRC4NCj4gDQo+IE9rLCB0aGF0J3Mgcm9ldHR5IHdl
aXJkIGFuZCBwcm9iYWJseSB3b3J0aCBhIGxpdHRsZSBjb21tZW50Lg0KDQpXaWxsIGFkZCBzb21l
IGNvbW1lbnQgb24gdGhpcy4NCg0K
