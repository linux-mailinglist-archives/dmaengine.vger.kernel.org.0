Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC05839BA
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiG1Hpa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiG1Hp1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 03:45:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200F52FCA;
        Thu, 28 Jul 2022 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658994325; x=1690530325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rvBq+KXijeFwOaFOZoPgK/kJ8rrfKrPDgvj1V+A9jcQ=;
  b=qIRILD2cKQ9qwHSRiBLoY4KE4taznsrnjL2YV2YgYoXxcf9D7zCGXIJ9
   KHr7cl1+OrSNoDKxL7rb1wbKgWQM2QlYUjI32LByKk3bVzVuiCJfxw+T2
   Kfq0lzywK+BD2BG7291a8mfIowy7gd+v1ocWl2hvsPjjfSWNZigbExPvj
   1jWbJYTlyYX+R3CKHDK+IVhGRrmM/WX72+RwenJUprtemNx5acA1s5Poj
   0eKKQASKz7VJAAKYjVokFMhh5x4WmGNj+/j7Yf+EFyBNI8obJsr94loS4
   2aDQGfb0nSNyCVt33UVbRCEMP1QVvm38FwVHTUjb+gYtzfFNHuAz1pbMT
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="166752862"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 00:45:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 00:45:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 00:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM350Yo6bv8QbTQyNyAiNN+N+4rZa2+xcLWVerf8m5FkiV+DB/0b7Fj6C2HbEgpFUQTFogBRKI9Smjd+F2yAMaiFYPA2tZJM19unCNvrUlLSj6uqLjclzE5xiIn4NnfEWJ6n6G7ORnkqF1+dxrSXHqYU8MoFCp4kx0/s0IhEAjqlpdm22Vnea8rXX9AkkkgmHoLKCZSV1nleFh/HGT2xUwLVXqhDJbxtGsVITr5dcqvKAbz1Tuwh5966hfK2Do7l1dWlMu1ApfVCpgE3O1vHLU2H5zGfruZmcUQt+q8STq9+b39ZjSi3vutBpydCiYiWMT6u5T2zN83S68hHbiWqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvBq+KXijeFwOaFOZoPgK/kJ8rrfKrPDgvj1V+A9jcQ=;
 b=ekrL1w09srGy6jFULB73X+or0wPPUbEWv+73fRZXT5RW66HZClilXQIHFZVg3eJQ/gj4+TVNFZji4Gv1h5mdgRHabOWEAi6bTdLztjHA0qr5doF8bGmTUzWHfPRsFiOyng+iTegEQsv2TcQoT/UrdHXznxPc6L4kGUM5xhvSdS1pp9RW+TPULfBrUFVe3xSXbvwKKtNBMjwLZHffDb40GvweTvtV+Wgc7c7dap63bLuA+xGd3oTRm1Yc+Yyz5F4wndmsoHwUc85Bl+OfYs1KBkrR1/gmFQEtXquQqPxZwLU2Rc/qrcS6NO4dyCAN8eJY83w+J+h9j3uu8zO8gLCihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvBq+KXijeFwOaFOZoPgK/kJ8rrfKrPDgvj1V+A9jcQ=;
 b=oLPc1ispraETVZBWc512TI7oa8oNRvkBO8Alcd1agDD/g1QxrQ3+xeMtUi+s9wzaOFYGhU3H5Q+Lzj3+dQ1KLPzYXeLDSplRlLQXixzt7fg8t1DQsSaDlUdsD2JrLxPlsceA4mFRNFA9SmmVFTPVAzWvvdf0talNAFAnJ7L4SSA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB2586.namprd11.prod.outlook.com (2603:10b6:5:c0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Thu, 28 Jul 2022 07:45:13 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 07:45:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSf61kLXgAgBkWqoCAFwhcAA==
Date:   Thu, 28 Jul 2022 07:45:13 +0000
Message-ID: <684f7262-13e0-f519-ffee-bbdb3ed80717@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
 <9104267f-6dd5-4e49-6a81-f377edceffe9@microchip.com>
In-Reply-To: <9104267f-6dd5-4e49-6a81-f377edceffe9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 393156d5-376a-4da2-c262-08da706d1ae6
x-ms-traffictypediagnostic: DM6PR11MB2586:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TS+DJrhEFT1J7ThdJGgO5Y4LSBjBHm0s7UrimJpGzyegUYcOcZdlfgBfdZSxu+lMSwu5sbqc1F1zLPm9PdcU2QQg8TOM1zrjpakDZb6tnZQNaNux0Edl+eGUtJHw5xVixSCN1qLGOz6DbVWdZRLBM0GlGiVoOASLg3SXNotD64QI5mRePPcSK+cgMEbp9E/JIzzDqKr9E3D0f1sHtzQDAR7CJVh31Qal+4pzj4Ts6BahKaGGJEHwblzettz+MZuiWZ6+UXNcrVoIII78GPdlUoKge44gn+PjB0y3ohLTh87WE/+nfnkJ2XmvCY3sI+pyUhUmHW2uBNk9T0eY4hCyFZKxVbuDeh3H1WjucFf/Uvkr1lEAdcp50q9ZAQI+kLuGVb1iSxgxnbKB2auQOwiGz8BswA0IkHpmkG7dwAYHD5c7dYzuKDzusWMkqsbdEiHW+KyW4IRYnyuyPO3MylPaENEa3WI3x0hWrSqhW3Xu7TdVOqYSrCpeWcVgooaCaMCK83kRd19YSmMYHR4UlEMIxyuifTTcDmJfVE2/lUJ+mDUXUv0cWANe43f38Kpv6/x2ChAMXUi+yOc2SVe81EsCr2tjjjwwAkBFp5QuJtUShkQP0Qo4O29U/xHaJBklsyBjH5tnWBice0QxecMCCm1gc6u+xjHiL7miefQnaSwBkPx4B1o69XAraKfFlPobkm9bFrO4+LAukE56dObgVQzXBuz2r2Y9eMMb9+T8XyAhVstGuoOVLsdOZ6+VlHICoi02xvULJt7HuS68R+XrZ01WbOjMZ/X1og1oh4DBiCgD7+XmksiBby71dt9aOo4lz09CKuM3CWlaujrs52mhaJxh/1OxBcu4T9vSLJqJ7+BT0QtdNZOFDJns9RC2faciz518ZG/FpMR0wBZChEQFjr394A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(366004)(376002)(8676002)(26005)(66446008)(66556008)(64756008)(66946007)(4326008)(122000001)(91956017)(76116006)(66476007)(54906003)(38070700005)(6486002)(2906002)(966005)(2616005)(478600001)(36756003)(53546011)(8936002)(31686004)(316002)(86362001)(186003)(110136005)(31696002)(5660300002)(6506007)(38100700002)(41300700001)(6512007)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WklRM1F5Lzh1cVdCdmNlTkVuUlkxd05ZZmpOMTNzTHRtWkpDL0J0K0ExdmI5?=
 =?utf-8?B?NkRjN1JuSWQ3V0tySmdNcFFIN0M1dVhDMy9qanV4T2Z4UGFTNTNGWjE2Ykp6?=
 =?utf-8?B?OXUrZ3lBemgwRkFRRTcxNDROUFp5L0c2dWlNRThibzZ6UGlaMEUya1YxQ3pn?=
 =?utf-8?B?ZDhRZkN6bXd6V0d3VHZmRTdDdnNCaitlbS9SZWFrTERMVmsvUzZtQm1oS0to?=
 =?utf-8?B?R1lncTRoSWtGa1AyblVjcDZ0UDkzZTFMTUU5Q0M4NkswaVRPVU13cXBYbnVx?=
 =?utf-8?B?emdTdTI0cWRMMlNZeGtRZmM5bHdJNm5tZHQ1R2NCcWRidGNHNng3RzlRdi9k?=
 =?utf-8?B?cUNldWhsN0Q0RWpjeGpxQlpHUHRhUWhiV05USjQwektKdXczcnFnSGNXK0tn?=
 =?utf-8?B?TjE1M2VTUWY5U1pIU08rVEdnMk5mTDNZd25maTRQTWRkOTAwOTRDU2VVNTF0?=
 =?utf-8?B?SVNPazNDcTZZM1h3aUlZMnhFODhVTm5tZXAxbGpPY0ltT3JBeGdsMmdST1ZI?=
 =?utf-8?B?VWRIUEEzNzVyMm0zcHhnUEdxeERHVjlmdm5iTTJBQjVFa1lqM2lUbUlEeW5P?=
 =?utf-8?B?REJuVk9Zc1Z2SHZXOCt0NmhmQTJLd2t1L25mV2VXNXBTOVlJVUpmdER3YUM4?=
 =?utf-8?B?eTJSS3B2NDhNTWJZZEI1d09MeEJ0b2djK0RXQXMvT0ZjeFVXblQvcWx2VHZ3?=
 =?utf-8?B?Q1NmdVp5SitsYzFFUllMS2F4MFNNeld5K0Z6bUk0U1NGWm8vUEc3dFlXNHZR?=
 =?utf-8?B?cCtoZFRMc0Y1YmVVTmxjNmxPaGo5VFlmWURFVTV2M2lyRlN3QkRydmVQeFl6?=
 =?utf-8?B?S3NpSjMxNitJZk9ra0U5TzQzNkViSE9RdjFBUkYwWWI3eHpJdU4xUGhqa1Qx?=
 =?utf-8?B?anB2OHFnRExrY0h6UUUxem9QRkdQSEUwWStKMDdsRDZ6MDhMQ1psaUpUUDdz?=
 =?utf-8?B?UjNKa0pVMHB1YU9QQmcrUzBwSWdNcmxCbXRwNHRGZjhlMXVvM2dmTVBWdURl?=
 =?utf-8?B?ZzVRbEZ0TlF1b1hGSm1BNWtDQjdkbzlweVBKNm1aQWhrbiticlFuS244emNK?=
 =?utf-8?B?UDJoVjlpcUxJTDFCYVFMVmt1L0J0cXBZZ3ZTNWRSNXJDdExNUjRha3BJUmFa?=
 =?utf-8?B?Z1ZabFBvM2p1clBDbUFoMVBmUGd6K1lFb1IrQXo2aGdCcXRXaWhseUdnYThR?=
 =?utf-8?B?Q3g0c3YvQXRpYk90Nzg4RG82ZXpkZlMrOHk4bkc5cjZldUtVNnhJWmhOMzVZ?=
 =?utf-8?B?TXdWTGR3UU1ZcG80TnNMRXhuZUllRWQvSXJWN3FhWXVRb2tBQWhDdlF4Z3p1?=
 =?utf-8?B?U2pTam1TTXpjRm11WElpVVpoODNxeGtXalljS0E3ME1KblV6VWJLR3hjMm1k?=
 =?utf-8?B?RnZYa1k2Y3RRbks1ZTYrRzc3eTVBaW5SUkhHWEg0K1hZOTJWZXgyY0ZielBN?=
 =?utf-8?B?OTh3cU9qdHBiYW5zTEtNL3RiWFlBcVVtU0x0VlNibU9GL1dIOHNNZUQ5NmZ1?=
 =?utf-8?B?cFJzSGo2QmU5aW1oNFNhYW1HekkrNjhmYm1MUWt3SVF0TWF6QTZPcWNDTTI2?=
 =?utf-8?B?M1JhSnEydlFZNVBIc0c1UGNLVmxwdVV5a3kzdjBjOEM0VlhSZ04raWxrVmR2?=
 =?utf-8?B?THBkckg2YU1BSEdacElyczg3dm15c2djcXpNd0ZlQVZ4NDlhWTVqR1RkbFRK?=
 =?utf-8?B?L08vdTA0RzNlU3doaWkyc3FpNmRmRldPOFdRSW50V3c1UkpENkJhV2IxUzAx?=
 =?utf-8?B?Rmp3Q0NLV2VYTEhUWVZ2VjlBbFlpY20ybnFRVmwyYVd1dDJ2bTRKQ3V6SVhz?=
 =?utf-8?B?TWx2TitRQzRKcGZibVZ3RW9hcm9jN3JnV0kwSkl5Uy8wQ1lLWG15WmVLd1dl?=
 =?utf-8?B?VG9jRWNQMzNRZW1TWi9DR0pOSm54ZUJNNUp1YVprbnhRU1dDcWVuenU2QnY1?=
 =?utf-8?B?OVVkSjgwRWJBNko1Ym9uSkFrMWFDb081QUV6ZkI5bXVHZ2Q1YjJzTUhYaWUv?=
 =?utf-8?B?T2RUSnFmOWZ1TmczbnBidEptd3RXc0M5anp2ZXVGZDJUalBNTXp4NHpiRWJn?=
 =?utf-8?B?WXdIZHZXWE1LWTcwR0xxN2RaOTVsNEh2ZDlYZ3drVlFlR0dKYVNuakkwbzh1?=
 =?utf-8?Q?42iVqj+FeiJ4CLmFzkDnfjdQ1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6B5B58A57A0D14791E2D3291C4C8A7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393156d5-376a-4da2-c262-08da706d1ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 07:45:13.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vNhGIFDKCXsHJ+8gDJn+2VVfCJw15ZH+DqTw4A93HoNZHydrqfNWoRrKricGN0J5EwoVQW0k+T6y7W72WJ+ndG33ziluv46QgyEBEFXJPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2586
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gNy8xMy8yMiAxOTowMSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLCBQZXRlciwNCj4gDQo+
IFRoYW5rcyBmb3IgdGhlIHBhdGllbmNlLiBJIHdhcyBzdGlsbCBvdXQgb2Ygb2ZmaWNlIGxhc3Qg
d2VlaywNCj4gYnV0IG5vdyBJIGhhdmUgc29tZSBuZXdzLg0KPiANCj4gT24gNi8yNy8yMiAxOTo1
MywgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSSB0aGluayB0aGVzZSBh
cmUgdGhlIGxhc3QgbGVzcyBpbnZhc2l2ZQ0KPj4gY2hhbmdlcyB0aGF0IEkgdHJ5LCBJJ2xsIGhh
dmUgdG8gcmV3cml0ZSB0aGUgbG9naWMgYW55d2F5Lg0KPiANCj4gSSd2ZSBjaG9wcGVkIHRoZSBk
cml2ZXIgdG8gdXNlIHZpcnQtZG1hIChjaGVjayBbMV0pLiBJdCdzIG5vdCBjbGVhbiwgYnV0DQo+
IGl0IHdvcmtzIGFuZCBvbmUgY2FuIHNlZSBob3cgdGhlIGxvZ2ljIGlzIGNoYW5nZWQuIFVuZm9y
dHVuYXRlbHkgdGhlIG1lbQ0KPiBjb3JydXB0aW9uIGlzIHN0aWxsIHByZXNlbnQgb24gaGlnaCBs
b2Fkcy4gTWF5YmUgaXQncyBhIGNvaGVyZW5jeSBwcm9ibGVtLg0KPiBJIG5lZWQgbW9yZSB0aW1l
IG9uIGl0LiBXaWxsIGdldCBiYWNrIHRvIHlvdS4NCj4gDQo+IENoZWVycywNCj4gdGENCj4gDQo+
IFsxXSBUbyBnaXRodWIuY29tOmFtYmFydXMvbGludXgtMGRheS5naXQNCj4gICAgYTczNTFlNmY0
YzEyLi4xNTU3ZTBkZjBmZDAgIGF0LWhkbWFjLXZpcnQtZG1hIC0+IGF0LWhkbWFjLXZpcnQtZG1h
DQoNCkhpLCBQZXRlciwNCg0KRG9lcyB0aGlzIFsxXSBvbmUgbGluZSBwYXRjaCBzb2x2ZSB0aGUg
bWVtIGNvcnJ1cHRpb24gb24geW91ciBzaWRlPw0KRXZlbiBpZiB5ZXMsIHRoZXJlIGFyZSBzdGls
bCBidWdzIGluIGF0LWhkbWFjIHRoYXQgY2FuIGJlIHNxdWFzaGVkIGJ5DQp1c2luZyB2aXJ0LWRt
YS4gSSdkIGxpa2UgdG8gZm9sbG93IHVwIHdpdGggcGF0Y2hlcyB0aGF0IGludGVncmF0ZQ0Kdmly
dC1kbWEgbG9naWMgaW4gYXQtaGRtYWMuDQoNCkNoZWVycywNCnRhDQoNClsxXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tdGQvMjAyMjA3MjgwNzQwMTQuMTQ1NDA2LTEtdHVkb3IuYW1i
YXJ1c0BtaWNyb2NoaXAuY29tL1QvI3UNCg==
