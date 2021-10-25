Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8ED439179
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhJYIhj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 04:37:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3897 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhJYIgs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 04:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635150866; x=1666686866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9gooXbARKQFZ6E6qD7ZMJVHHGTMMQcS+yABsZFYuJcI=;
  b=woMLPBf44Mia/DY2Z1WhJvHOO3zP5IVDBRVMUvFHiFDWQfMepI4VR1tL
   lnqhsK7uNbirdWx05xVMio/Y40OaRgURKx/1YMyO8jGmZM+uS+shkO0bo
   fewDVPVbe56D8lektapvNFc7grD7rz/v9ZCwuzryNj01d5n3msfeZhnfn
   OKSsRdiUS+rGE/awVaCj+V9nv/KcRC7vrgB4CePC3xwKyNursQLvPlWPm
   7JSCLSys2f+yYa/20iof7IXOHXR3Lv6KZqy2ud+zXbWvcUtveA80RAMkA
   DQfIQeMcvdwwdHFDbLTnq1P0BKakX0pUTkP1Ugvwq6J7C/PUh1pl5yCRc
   w==;
IronPort-SDR: p2hIdoCM3hqER6XaVSKvmN5G8cNnJeNbGkxqd76S6ThgE3yMxV9iP7OMtzvQ0zYFzkyqPzQmOI
 agpd34HU9LQPayCNNkmvjXrhjeho+7L7mYzPuzgcic9+ccYh8hgKx7nm3CykOtiJuDafZQw2Z4
 bWD6qPHA/rz8cAbjJRH1pzNe5eJ//+DfvjHrDHlc740j8QM7RQXIDYIvXbcvfYmd+ymTZELe1K
 F0S8zXNjFjTjw0ZxP58MzCscSFJw9B1AnsFvz+o9AaYY3EM7pCM0ddKQtRnBNGiAoI44DoHSNh
 cTNrJyakefuFz9wSTLMwaP0T
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="149379525"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2021 01:34:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:34:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMIBCmhiurFXjGB400CSyUuXQa2O4UHvEwMg7sNCNGg9DDev8/qzTfR3v/LRGxuYKXe10+0XuhvsMkv0aVO1Xy0JsdI93o98JgRUqpEAwxA93bggWe45gu0WMyxuOVYeidVtU3jsXytoqhNYYK0lF+gHBTfcUM5/u6U7U7YEqBclljdI9mfZlLxiN4Bf0FHP6TIWNBGXpGTLXRJJ2aHnjrpC+TB6yde6vF5g6lEg+yxpjnSklUIczIKd2qTM9c4RmU3+yP8PKsYWrwl6wJ5l2ud3ajMTmAvxykshFftrw8sKqpqzAsQzgV1GcjUI1wOS/PuBR8QVzd9s/WoGDPvFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gooXbARKQFZ6E6qD7ZMJVHHGTMMQcS+yABsZFYuJcI=;
 b=DkFXjKS3G0XrYQqvwIDhCB2K04PvnHyh1eE+yFvOySVL17fJZpRBfW6BarL82W2DPfY/SEgGQ7tgScG0QuMbLgToLjBYiStZ+dhMUENMH5a+L9ltsBwEM5zUHIrgac0tJZW44H5ggBIhuLj09hJ4yw6yGyRMj3prsPh540FuQxWBJ3A3vn63/0/tgbZt9iG2iuF1uCeSr+0ALjtCO5ScI085oTlmAev8JNz4FCVDUcDLgcCM1MrJ5gMwgz8ItXy8XIdjE1kVZWShEB6rMH37W5bJPQU8YeiqSDLBlz31NOb7BueOdJWv9VSlNWWFKVQm8kZcPi6go9IIGX9f5oDzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gooXbARKQFZ6E6qD7ZMJVHHGTMMQcS+yABsZFYuJcI=;
 b=lHZ2fDY98YigO8TkLore18D0FzbdK33rnq820Zn9sPdyoXXcmwN9h7vlT+Be2390uT8YRCYAST1/kBMQ3c9FqKock75rDFvQMIrhOljs/H/Zrj/Z70PzQEZi0ppF/mxUo2U16NuKYGe/5lA/ywD6CeAJIC1XH3aZzk1AU3wmqpc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:34:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:34:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: fix compilation warning
Thread-Topic: [PATCH] dmaengine: at_xdmac: fix compilation warning
Thread-Index: AQHXyXsd68M96v2TEUKwKFpbHUbwFQ==
Date:   Mon, 25 Oct 2021 08:34:24 +0000
Message-ID: <ef3f66d0-f07f-cf87-fa9c-c4ab4e565ac7@microchip.com>
References: <20211025074002.722504-1-claudiu.beznea@microchip.com>
In-Reply-To: <20211025074002.722504-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5fd89ed-ebc9-4fe7-b5e2-08d997924030
x-ms-traffictypediagnostic: SA2PR11MB5164:
x-microsoft-antispam-prvs: <SA2PR11MB51641476074CB467FA9334ABF0839@SA2PR11MB5164.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBqWohPyn/4lO+QCYDjdEei6PjubrSzQNrgTKzJ4OKGbDTakJQ0cs1Wcl2C75gFoTnfHpxr/y/bq0t5/8JV4X2l11P29FNctyi3eLOa3nNGLb6HOfEkn8tZhlST/7KHBKkyl/hYWM7F44m4CrBlpuQUxlBKysOijAzZN35d7cWS5uNu7KLr4TNh6p1phE4g3DZd+6mVo0wFH9SM/B3qMQwvNqxLGYhRJvJEqkWDl2hYaNhzJH7fzgiYYoo/h6E3dH5Omr7ko5gViiXy4SLrBa0nrU4CPdUjcuim/1iBSisfOnOUUHubCKBq/ziBj8IquWKO089WoPqlfVdF5zmNtTLpQRw7zb9VxWopacyWQYpurZiEpeATWGBdX0Jvc9TH56ScBiXUaEFXkZQTGRkohRSXklPIpLJ4Y/SgL+CpMrrDMF5cLVEVy37jDZatc1gAwJqmWLBlO79s9qsFy1K5iPB8sLbs6RdG2nS2adReTQ/eBthStD5LlBQqSFLQyJE6NGQ1o85WiNw8NHkwjBCBATpX21EKrmbIu2c5vKtU8abd0IuqSQkdWdKfiHwM8WAuwdsexM7h9RBXe9HydU/BBrb4+XKcU2dBYo4vGTVRkXpYZPcPYrXCxlNG3s/nBAaRb0sWPMg7TGXpOT/Y1+Y/FWME72wQxEEyDTmUjSRJGZmhDhTXgM2H7h88519oS9SZfirenbWAUQTL41Wv6zugAhVJT7pg5nmZ73JB5e2lEgARC8YljI+x2iyxjEc3qzZgNe3+2YFnDtDPDBFND3BE2FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(71200400001)(2616005)(8676002)(508600001)(36756003)(26005)(4744005)(6512007)(91956017)(5660300002)(86362001)(38070700005)(316002)(6486002)(76116006)(38100700002)(66946007)(31696002)(66556008)(66446008)(66476007)(64756008)(83380400001)(4326008)(2906002)(31686004)(54906003)(110136005)(6506007)(53546011)(122000001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTBMTUVVeVk4R2wvMGIwT2ZkcWFud3cxdHY0OUw5TWpwbm8vdSsxT21XY3px?=
 =?utf-8?B?L0ZWZUdRdlA3QUEyTHFWYWw5SkIrZlZqclR4TzhuTTlBclhoSVFvb05LZ0Yx?=
 =?utf-8?B?L1ZsZGhmbm8zbkg5aXlERjg4aGRUc0R1MjlpQVZZN1d3MjFES3NMTmpWb09W?=
 =?utf-8?B?TmNkNW9rM0V3ejM4NUV2dEtqWUpRVXdtMGZBRDlCQXZjYkNCbmRZV0JPTThX?=
 =?utf-8?B?c2k5RG5NditUWkFhYkNteGNGRUQ1UEhwaE13NEp6TDVkYnFCcUF2bitQdEgz?=
 =?utf-8?B?a1FaUlNlOVM4TDZIcWcwQjIzQlNLMk8reFlGSnJONGp3b0toODlVOGlITGpU?=
 =?utf-8?B?elp1UUl1NE5qVU1iM3JsdllaYXVYZFJHeWdlbVR6eFNZUXJmZmJKL2JQZHVM?=
 =?utf-8?B?YW9pN3V6Vy9oTUtTSEo3NEVJVEVNRlFQWlVxL0Z4TDRkVmd5cStKVUUvVkhm?=
 =?utf-8?B?eWdZTG42S0JVTUF2SHRxQlU1WGFzb1RhdUJOZkFqZm40UHN5YXpaMGlWK2VH?=
 =?utf-8?B?L2QydW9Ha2RaL2luT2ZnVXdWdGFVRnFEcUgvVDJZZGtPalVzL04zUGc4RVRS?=
 =?utf-8?B?Z0tMZlJFODNJdkc0MWcrK1BHK1luZnRvbU9tYmN5anVNZUFTeVlMYXdjRnBa?=
 =?utf-8?B?T04zM3cwREcweVVOWTBWOExrSURncmJUV05oNEsvcmt5RnZiNGk5cUE3WjlU?=
 =?utf-8?B?VFJPL0dqaDFrL0FaVGs1MkM4UjVzZG5YTEtDN2xTK1FZUHUzNmhKT1Z1aGl1?=
 =?utf-8?B?SHNiaTZXQ0cxWUQ2b0lmS3VibDdMb3lmNmp1QkZORmo5T2RqeGFPWEIrdnpG?=
 =?utf-8?B?bi9vdHpPby9vQXVHb0Ywc1pObjM4N1B0VjNuMmNGUFRxMFU0WjcvUmE5T1V3?=
 =?utf-8?B?SjFzaXlCQzQ1akJQMUNndEdiZjhYcGJDR0VFTXBnOC94YlZIUnQ4bGtxU0pO?=
 =?utf-8?B?Tmg5MDF1RXZSU1BmQ3JsdkswR1lNYVUxWU9jZGYxdXJoWG5lQWxWQ3BNVlNB?=
 =?utf-8?B?dGhjOEhrM0JUOFZkd2NCMEI3YVcwU2dQWFZha2dHcXFNTUZvb2FRVUpwMUhP?=
 =?utf-8?B?ZTFSdTNMTUZjWGtkeUpVUFhKb1UwMkJJSGxYcmYxT3IySTdGZ0IxZ1dJcDJi?=
 =?utf-8?B?Y1A1RWsvT1dKcWplS2lxZnpwNk04WGlLTDJ0SFhLLzR6Z1JaZC9LczNQZXFj?=
 =?utf-8?B?ZzBXT1lvK2hneTRHVlQ3RWJwSHpqSDVSd1h3azJlT2dpZHlKRFROTXk2U3Iv?=
 =?utf-8?B?MEF5Q1FHVzhWN1VDYi9XZHlDdFFVbjFmaGV3SWI4c3R0TjI4L3NacnYrRStu?=
 =?utf-8?B?N0JYZmhVdGdIRFNncHFzK1NsZkJnVGI4UitxUTlaTmx2ejMzYndsSExvcWxa?=
 =?utf-8?B?eEl6eXEwY1lkbGl5bGdNeWIxRm91VG9nMGR1V1hCSUNMT2FiSU05aWZHelRI?=
 =?utf-8?B?TWVYNnVkZFJMdWtsZWc1a0VRQXBnd08yUnVyc3BXM0FhVkhLek4zWGkxMHN4?=
 =?utf-8?B?SHB5VWIwSHo1b0NwYXU0VktmYno1TW1IRU1XVHJFRWtjd3ZVcG9lUXpJMUJi?=
 =?utf-8?B?alNackVObktmSmtTKzN1TVJtY3c5V0w1RDkzMTJmWEVQMTl0MWFxZU85amVw?=
 =?utf-8?B?L2Q2YXNGTW5OdFd5ZXM2T3ZjWWpEbFdRdVlQQlBPV2oyS1ptcVI5WW0rWUZk?=
 =?utf-8?B?ZkRVVTF0RTlzUTFROXZ4UnNMYS96N3c1aXRpVldjQjFpZWI5ZGFia2ZPMlRu?=
 =?utf-8?B?SC9ZQkRXOUZMZE1RY1VzQUVwckNTdURycnFEZ3Z0UmhBN0U3QnRWenkycVZj?=
 =?utf-8?B?M0UvN201T0xOWHFIV1lVR1pidHFaMHB3RmlLSmtHQzB1aTVqdDB0VnZnM2d5?=
 =?utf-8?B?Y29yeTVvaGZIUE50cGF2QWNiVVg0ODVWMm1BYi96L2I1cmRsSVBEV2FjdFYy?=
 =?utf-8?B?SDBQR29qQ0UxU3FPM3locEJjSC9rdTN3SzZFc0I3cnFkd2dhS0IyN1ZoR25W?=
 =?utf-8?B?Smh0bjRxVEhXOURvNDZBSUxYZEZGeXN3NzNMZzlNYkVEQlRqam9tRm9EcXVq?=
 =?utf-8?B?S0Q0VndxZHdzdkRPTkdpRTF2Y1BOWnJVM2tJQmVkUXVQOWY4RWl6OG9OQkln?=
 =?utf-8?B?SXNxQnhqcFJmaEoyU29CRE9kd1ZVYVR0VlF4UnFQL2JWNHd1SER2dE5ON0E3?=
 =?utf-8?B?bTZTV3BrN2NuNVdtbCtNc0NmVGRMSTZDeE4rYjBsR25jZWJvZ2FldmcrcTJm?=
 =?utf-8?B?SjdsV0VXMHVKU1pna0taQ2NDSEhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042C23F48F31BB4084377AC98FA6B36D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd89ed-ebc9-4fe7-b5e2-08d997924030
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 08:34:24.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ricADt5142jjpE9jLzscapNMvKD1swMLXfB2byipv9aRzoEdHCEyRqJEXzNTObVo/JCMRKbwxoTJqFJHkWyI/Ys2VuaVwmebLv/WPRa6gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvMjUvMjEgMTA6NDAgQU0sIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPiBGaXhlZCAidW51
c2VkIHZhcmlhYmxlICdhdG1lbF94ZG1hY19kZXZfcG1fb3BzJyIgY29tcGlsYXRpb24gd2Fybmlu
Zw0KPiB3aGVuIENPTkZJR19QTSBpcyBub3QgZGVmaW5lZC4NCj4gDQo+IEZpeGVzOiA4ZTBjN2U0
ODYwMTQgKCJkbWFlbmdpbmU6IGF0X3hkbWFjOiB1c2UgcG1fcHRyKCkiKQ0KPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1i
eTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9kbWEvYXRfeGRtYWMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1h
L2F0X3hkbWFjLmMgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+IGluZGV4IDdmYjE5YmQxOGFj
My4uZjVkMDUzZGY2NmE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+
ICsrKyBiL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gQEAgLTIyMDcsNyArMjIwNyw3IEBAIHN0
YXRpYyBpbnQgYXRfeGRtYWNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBhdG1lbF94ZG1hY19kZXZfcG1fb3BzID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZf
cG1fb3BzIF9fbWF5YmVfdW51c2VkIGF0bWVsX3hkbWFjX2Rldl9wbV9vcHMgPSB7DQo+ICAJLnBy
ZXBhcmUJPSBhdG1lbF94ZG1hY19wcmVwYXJlLA0KPiAgCVNFVF9MQVRFX1NZU1RFTV9TTEVFUF9Q
TV9PUFMoYXRtZWxfeGRtYWNfc3VzcGVuZCwgYXRtZWxfeGRtYWNfcmVzdW1lKQ0KPiAgfTsNCj4g
DQoNCg==
