Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEED4723C7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 10:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhLMJ1w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 04:27:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4504 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhLMJ1v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 04:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639387671; x=1670923671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=reS0kdiGrNca1DG1v4rmFK0BVyO7s/UdfNQFdmGVzsU=;
  b=KMy4+Ygb8tXIsuEiQVqRe3LSws2RE/dw00mB2fMxNl3wSb/yZp/R2jnu
   XwIUntAGi8Jl0kGo+h59IAiH5l2L4lkfwn+M7SD3ZJcGmmIFm39Wyl2Y2
   OaByd7R8rkuZ0HvcOjv0k7Q7nVIoVQKSP+uc9uUbXi3Eo+rAboq8RrR+S
   W77mRofg5cMI5oFWOzb1qP6ZkUZVcdkccmrunquArXBQqrIl0bQ4oKUCU
   dmLbah/qkqY/bnpa5jr/LqbdRYOQBQ8URpmUY/y/Y/9KnWhUmx/JAi/hd
   dmqzCkQX9boMpRlDeAk9so3VGhasNS/79QlC1LxEqyOt4XAx8R4LnGNPF
   w==;
IronPort-SDR: ErsteK1ID/FcUzj7FU7OEYFoDYIfdqLl5e2e4AQmjoZE+0IzfTGt1SngwP0fAOwcuG18NgAprE
 nD8Aa45atGQEiIobWq4WxbeS1BAH0yWSVf3WtMIsYULgkbYn3AbImm2f+KAk3Dr2tMHV/XdnYW
 PoZbm5PIwPJinM4XA4ND8RH5SV7Lyhrr+NAAJDjMsDicAl3BOxbB976/QANYh2z358/jkaBu3S
 hr5etA+fqe1o1aGpPQLUMLk+j60iraB1dCx77J+vxRfTTpWSXdVmoicqaVWre3gjz4nquCqpyu
 vtL8FATX7db6u8+DqjgSPk/J
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155246667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 02:27:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 02:27:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 02:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5kpZ9kq39dWT2IH5W/oQGxF2HSvQ9wysK0+ndv/+6exNH34AX+ulo5lYUdzEtpFwpTXPtVQYDcfPtWjTqqjRfBF8jA4Q//NAVpwcLaZYNdOfIkg2k8Ug5MjK1jGQ2X3KMLj8Vh2Vs/1FnmKGXe10KS5xjySiNRN13c7xovReBN04htwwTloUe7OK5Va0MM8tuFZ7GXGWV8cBD3eYERInfT6yVvRLRiQG9WmrSERdjmm816nVM9wyr2zHY/xsJm/G1XyJ4/9TBY/rD1s9pMWWG+3mXfa94DUlTraoolz5qbHU2Pf4UbJYLBWMII9i9sJ02jMGheQpfWJMu3piWxWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reS0kdiGrNca1DG1v4rmFK0BVyO7s/UdfNQFdmGVzsU=;
 b=LnH6t5RQDS8qMJrxNKi96Qd1HPBL3rC0VYypBTaDWHwCJD0WZTfql7ZL4aPsvoXToFxaWGDGERxXfbIscyNjoIKCSjXClchku4f3v+fFD3iaZnUAZp7vvyD+iQ2nU1wxV6vUdhrKU2Ql6bTb5ACzcmP709rT0MpfXGZvNwohA+RDAPgvkdk3a7gk11eRjr9kKmsksmCnacCW+wL9VGTJE1zovDlBdJYHy9Ib/ZITVtjwgqsGqQq2vlxKm5nL59QB4xrH/Fs9GfX/Z3jXj0e4Ln0Rncp1XhOdLRXfu6vkoysSb72T5p/pa2VKX0UupaBuuk9FaOQxioRh8W4CSFiYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reS0kdiGrNca1DG1v4rmFK0BVyO7s/UdfNQFdmGVzsU=;
 b=mMiVHuROAzp4DUQLrksNVTu2qgnenr1C4yjPG8UYksdzsAuaodEeAMkHn/V7s/S0Bsy3Unwr903449DuN5Xa/2vtG2hvVSYrVVo8GNP9h6IFaMHGx+H5WSsfZDCU7CW49IPOjbjr1A/49wk4/h8nqxJXA5YiZQ+2hd3Hyx7MSDY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3533.namprd11.prod.outlook.com (2603:10b6:805:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 09:27:46 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:27:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Thread-Topic: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Thread-Index: AQHX7/6cGW4RS1ZeJkC0M7VpsR3jOKwwJ2GA
Date:   Mon, 13 Dec 2021 09:27:45 +0000
Message-ID: <dee19759-df29-0e33-8c92-a770711b4246@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
 <20211125090028.786832-9-tudor.ambarus@microchip.com>
 <Ybb/PV5M1Gi59s7I@matsya>
 <8523ca32-d36f-6e0b-0115-5e07553396f1@microchip.com>
 <YbcLjrMF0YrCVgjc@matsya> <YbcLx0wGFvFnvSXY@matsya>
 <3d57524a-6d88-3027-d8fb-94417ae0b4f6@microchip.com>
In-Reply-To: <3d57524a-6d88-3027-d8fb-94417ae0b4f6@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7267c9b0-b47f-4bcc-658e-08d9be1ad27f
x-ms-traffictypediagnostic: SN6PR11MB3533:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3533E0DD519BCC02AB3251C6F0749@SN6PR11MB3533.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTGWYxSrI7RRjTja9uSYiwHdfsZtOrSO2tye6t0K8dmLZXAoX9M2ihf1fWxyAkgaFwhzLcoXknPcURXcyowKIHWI3iG5egph9XWqzw9bWwXXF1EmHEvq73jBi07AN5Sf99dN4Bq9lamreWzgWmuXcDgoiB/gK8iDyLkGbas0TcfwMkK1T7zaVxw7Dq9r/tGwlju2igBLwAypizoeOTAcwNPctiyyy6bNnbCMA+eC0NE6WqL43wz+jCReXkKmQH1TENxK/Cj4VH8H8bsVjC3+92kVqu75aZKCjVUi0p4lCVUq76r0+PxeFxUUhBv3iy4RMicbIcdnYf+9rlweGxeuLVEsTemXyr8PwLFt05zVCdCpcZk6AhjTkUblSMwu2j0+E84KqXyuXajVejRKnS3r9HcoRcQvBCGbS/r35yA6c4oxksOjJ/CcLSaZphzb5TV5yx7s0lXPHL8sd8Nmf5+WulCtlx/SnPPC9e8rmZyc2ALOWCLFBiQMgpPZ3ke7DqnCUfyNPk4x12VAi5ukhXxbEBEINFV2tCDRFe9D1W02lEyJCfnJKFedoRi7Yh4cAQDyoVpdfM3s93imb/XS5BzO4y4GZ5+R0NC9M3qXzy6KXcQtfbQMhk6+kR6G/YMdXXzLo7UXoGlymhl4+wS7r5BOe6Dm5YElT8ySrNQGh3dYrYHPwEEC2gxStggWYO7YHGrLcGDYIhJgHcT6MrfdLJ82JEYB/uo+ydkIqE7Vspb43C4798Is7ztAPSt5G6pv8aXxMvk9ltNX+4WLIbc+kWcH+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(66556008)(6512007)(66476007)(2616005)(6486002)(66946007)(76116006)(6916009)(71200400001)(8936002)(31696002)(316002)(66446008)(36756003)(2906002)(64756008)(83380400001)(38070700005)(4326008)(26005)(54906003)(186003)(86362001)(508600001)(122000001)(38100700002)(6506007)(7416002)(31686004)(8676002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2g3dzlpV0lkNm5QbWFOcU1ZOXV5WlNZeVlhWEZzRzJjM2d1YkxhTHpkOWtE?=
 =?utf-8?B?VmdXc241cDNtNGpvRG5LRTByOUt5RjVFZm1XYTBKN0VNOXREVytFU091dC9a?=
 =?utf-8?B?TXRtUUxBWGtma0Y3T0xHcy8yZWFvdk9UajJ4OUxNcktucDYvcFJFSkdwSEwy?=
 =?utf-8?B?bGdTTUVTazNrMFJid3grYzFiOXU1VVdWQm96UUJwL09kVSt0c3ZLK29nMmZI?=
 =?utf-8?B?Z3NNTmZHandSZE5hTnk0elZTTzRLVXQxdEpvL05VVWd4c05uN3ozdm1vUUFw?=
 =?utf-8?B?MmpicElhdGRRRU5KZW5uVkJMQW4xWFpqZk1FOWpsY01iUGJKeWlzbEY2UTgw?=
 =?utf-8?B?U0ZmVHRKWkVQTG5UdHplVDkrR1hveEJlVkExYm5ZMnQvTTNQenFaeGhQdzdr?=
 =?utf-8?B?VEVlRE9uYi9CTUdTbmpsMjJONlYvMzVPRUtuYVZ0YTJOZTJtSVd6Q09vMGto?=
 =?utf-8?B?M1ZTK0J4R3dlRk5oeDFqMm1YRHp5T1VkZC9oR2MxL3ZhWXJvSlVNenJqdkNX?=
 =?utf-8?B?dTM3WFp1L08zcjVxVHBtZmNUWVR1N0tMRGpGL0pWem1sZ2l3MGxXUVNIQ0N0?=
 =?utf-8?B?OExlSDhtTlhaakdQL3lFL3M5aG9PdVBzaWIzOE1MM1hweWFYcFlVWTFEWkYy?=
 =?utf-8?B?eGRkWk5Yd3dUa2hpL1lDM1E2VGF6NEg4YzM3THlURW9laVMyKzFjUUIvRy9R?=
 =?utf-8?B?dXZURHloVFlIR01zNmxjeHZQVFJWOW9NVXZIam01TVd6bnRrVlN5aHJIeFFG?=
 =?utf-8?B?MjRESjBxM3JNMGtVY0FEZlhhSUZuUlQvaklCSXNPbnpUekx2VDg1R0U0eVpu?=
 =?utf-8?B?MjR6V3NwY3IrNWxKV3cxM2srWWRheE8yU29pa2k0ZHFTQ3gzZEF6emtLQmQr?=
 =?utf-8?B?UmxlamVLWElHNlNOeU5sT2lPRmVQL3JlSi9VWkNLZlJMcFB5dWF5a0RNZjR3?=
 =?utf-8?B?TDlvYk14M253dW5ySE5aVG1xMm5YWVJVN3RHMFFvUDQzY0hwZEQ3dmVDaEhK?=
 =?utf-8?B?cFpGa0hnSW5sZ2dRclBMWmFhRFBaOHVUU1Qyb1lRNTF6UXZRTHYvVTZLVjZy?=
 =?utf-8?B?WThXOENReG9qQWhQc29rbWF1VWx5VDVNU3Z4Ym1wZHVIS0NxaHA3ZWU2OXRK?=
 =?utf-8?B?NDhNdmY4NjBla2c1a2cyMWtkZVk5VGRadmc2eDNzN05Bd3dSRnB5QWZrdk5G?=
 =?utf-8?B?ZENSZCtTOGhCZGVVcVgzS3pPbVNDZDF3S2N0U2dWVVhMbktxQ1BvRldrSWs2?=
 =?utf-8?B?WkJocXVpQVBqSmZqQ25Ldk5LVEp6T1ozQ0tMclE2dXFJTVZnSlVValJRK1hB?=
 =?utf-8?B?ZHplNlE4b0Z2YlVSUGFwN2tmcCtNZ01aeEs1QTFHU3FkTG9DWXVNQ2dScVUv?=
 =?utf-8?B?QktIejRUQkxBeXRFcElpRmEweTBFV2xUU1Vxc1J4Vm5hYXNodmdzVXJXOFRx?=
 =?utf-8?B?Uk9mc2tmVzM0ejgvdlVCSXQrMGQwQjdvZjE5eitLdlFiNnJCMDJnTFBWcUo5?=
 =?utf-8?B?WmFRdEF4bkh1QVI2YUdWeXNtSS9CcFN5YVVaU0dqeGtsRFdOTk1rUzdvTlNp?=
 =?utf-8?B?a2t6TnhMUitidHdwYitGN3kvTE5JdkpRRFo1MnRTYjNzMGQ2UGs3OTVoWEJq?=
 =?utf-8?B?RVA5SmRubjQwQXNCQ2t3eE9RZkFxWVFOUk1KV0ZLMlM4bkdsN0Zsa1RiUFc5?=
 =?utf-8?B?K1g5NmpaRlk1eEVIYlByeUg1azh3WU41WFNnMDhmd0gxNkx6TWF4T21qanlz?=
 =?utf-8?B?Tzc5bUQwS084b1JOckxrbGoxQ2QzZ2tzaTMrTHlvOEZSRkF1dUZ3ZitMVjBi?=
 =?utf-8?B?SXU0YzRVbUt2dzJINy82ZmpyMkRlazZlWFRINlVCcVJ1YzY1Y2pGNlpNNTFl?=
 =?utf-8?B?RHVwZkJBZFp2bko2U3p6anhsM2FpMGt6K1hGZkh3eXJUNS9aeXhZeUk4dDI3?=
 =?utf-8?B?WUZRUCsyL1dqZkxRWUY4U04rM0VkUTF2Njk3aE1nNis5R0pxbVdSUVZvV0RS?=
 =?utf-8?B?a1E0WEUvNFZJYkdpUUN5UVVRcTNSMjJ1ZEovYWM1ZFBITWNVNktEN3ExQzF5?=
 =?utf-8?B?Q3V5WEZjbEtIRUJaTWlLd3pPVUdld1pFdEJ1TVJmZjNpdTdFNC9udnhISjl5?=
 =?utf-8?B?SG5yVFN4WlZjaEVvZ2dMTE9VeDd5UXZvaEgwT3V4dlZpVzg0UFNEOCtWODlD?=
 =?utf-8?B?Mk9EU1hCYnBCaURHSmtHRURHL1pPWExnWW1tWmw1bmd4V2NJMEFhSWJQek1v?=
 =?utf-8?B?L09OeHpydUw4dUxOdmoyNVFLSVdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5CEBE32603F8A49AEB3F5DFFD9B9566@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7267c9b0-b47f-4bcc-658e-08d9be1ad27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 09:27:45.8721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1ly+KiAoRfUgRNM4FSgJcxIk9TsJ/ERwf/8sKEW6/JgmkPEJek+iYMP762obGWI3Q/FbGp1sAiTVi+BOFas9mOSIifRQMMO+GRXGdghJ9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3533
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTIvMTMvMjEgMTE6MjIgQU0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+IE9uIDEyLzEzLzIx
IDExOjAwIEFNLCBWaW5vZCBLb3VsIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pg0KPj4gT24gMTMtMTItMjEsIDE0OjI5LCBWaW5vZCBLb3VsIHdyb3RlOg0K
Pj4+IE9uIDEzLTEyLTIxLCAwODo1MSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4+PiBIaSwgVmlub2QsDQo+Pj4+DQo+Pj4+IE9uIDEyLzEzLzIxIDEwOjA3IEFNLCBWaW5v
ZCBLb3VsIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
Pj4+Pg0KPj4+Pj4gT24gMjUtMTEtMjEsIDExOjAwLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4+
Pj4+IFNvIHRoYXQgd2UgZG9uJ3QgdXNlIHRoZSBzYW1lIGRlc2Mgb3ZlciBhbmQgb3ZlciBhZ2Fp
bi4NCj4+Pj4+DQo+Pj4+PiBQbGVhc2UgdXNlIGZ1bGwgcGFyYSBpbiB0aGUgY2hhbmdlbG9nIGFu
ZCBub3QgYSBjb250aW51YXRpb24gb2YgdGhlDQo+Pj4+PiBwYXRjaCB0aXRsZSENCj4+Pj4NCj4+
Pj4gT2ssIHdpbGwgYWRkIGEgYmV0dGVyIGNvbW1pdCBkZXNjcmlwdGlvbi4gSGVyZSBhbmQgaW4g
b3RoZXIgcGF0Y2hlcyB3aGVyZQ0KPj4+PiB5b3VyIGNvbW1lbnQgYXBwbGllcy4NCj4+Pg0KPj4+
IEdyZWF0IQ0KPj4+DQo+Pj4+Pg0KPj4+Pj4gYW5kIHdoeSBpcyB3cm9uZyB3aXRoIHVzaW5nIHNh
bWUgZGVzYyBvdmVyIGFuZCBvdmVyPyBBbnkgYmVuZWZpdHMgb2Ygbm90DQo+Pj4+PiBkb2luZyBz
bz8NCj4+Pj4NCj4+Pj4gTm90IHdyb25nLCBidXQgaWYgd2UgbW92ZSB0aGUgZnJlZSBkZXNjIHRv
IHRoZSB0YWlsIG9mIHRoZSBsaXN0LCB0aGVuIHRoZQ0KPj4+PiBzZXF1ZW5jZSBvZiBkZXNjcmlw
dG9ycyBpcyBtb3JlIHRyYWNrLWFibGUgaW4gY2FzZSBvZiBkZWJ1Zy4gWW91IHdvdWxkDQo+Pj4+
IGtub3cgd2hpY2ggZGVzY3JpcHRvciBzaG91bGQgY29tZSBuZXh0IGFuZCB5b3UgY291bGQgZWFz
aWVyIGNhdGNoDQo+Pj4+IGNvbmN1cnJlbmN5IG92ZXIgZGVzY3JpcHRvcnMgZm9yIGV4YW1wbGUu
IEkgc2F3IHZpcnQtZG1hIHVzZXMNCj4+Pj4gbGlzdF9zcGxpY2VfdGFpbF9pbml0KCkgYXMgd2Vs
bCwgSSBmb3VuZCBpdCBhIGdvb2QgaWRlYSwgc28gSSB0aG91Z2h0IHRvDQo+Pj4+IGZvbGxvdyB0
aGUgY29yZSBkcml2ZXIuDQo+Pj4NCj4+PiBPa2F5LCBJIHdvdWxkIGJlIGdvb2QgdG8gYWRkIHRo
aXMgbW90aXZhdGlvbiBpbiB0aGUgY2hhbmdlIGxvZy4gSSBhbQ0KPj4+IHN1cmUgYWZ0ZXIgZmV3
IHlvdSB3b3VsZCBhbHNvIHdvbmRlciB3aHkgeW91IGRpZCB0aGlzIGNoYW5nZSA6KQ0KPiANCj4g
U3VyZS4NCj4gDQo+Pg0KPj4gQWxzbywgcGxzIHN1Ym1pdCBzZXJpYWwgcGF0Y2hlcyB0byBHcmVn
IHNlcGFyYXRlbHkuIEkgZ3Vlc3MgaGUgc2F3IHRoZQ0KPj4gdGl0bGUgYW5kIG92ZXJsb29rZWQg
dGhvc2UuLi4NCj4gDQo+IEkgcmVjZWl2ZWQgYSBwcml2YXRlIG1lc3NhZ2UgZnJvbSBHcmVnIGlu
Zm9ybWluZyBtZSB0aGF0IGhlIGFwcGxpZWQgdGhlDQoNCmZvciBjbGFyaXR5OiBHcmVnIGFwcGxp
ZWQganVzdCB0aGUgMiB0dHkgcGF0Y2hlcywgbm90IHRoZSBlbnRpcmUgc2VyaWVzLg0KDQo+IHBh
dGNoZXMgdG8gdHR5LW5leHQgYW5kIHRoYXQgdGhleSB3aWxsIGJlIG1lcmdlZCBkdXJpbmcgdGhl
IG1lcmdlIHdpbmRvdy4NCj4gU28gSSdsbCBkcm9wIHRoZSB0dHkgcGF0Y2hlcyBpbiB2My4NCg0K
djMgd2lsbCBmb2xsb3cgYW5kIGl0IHdpbGwgY29udGFpbiBqdXN0IHRoZSBhdF94ZG1hYyBwYXRj
aGVzLg0K
