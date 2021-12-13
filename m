Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D32472339
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhLMIvd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 03:51:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20878 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhLMIvc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 03:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639385492; x=1670921492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m6tY5ZhDX7Wq26ik45c4+BxekC/9eLmFqyaRANWP7xg=;
  b=0avwEOuZXLgrBEaCL6Sb6obpdytdwY3tL1yrZEH3k70mgyICwFA/g4tF
   6dl7eUlrSF+MDfwxgb8kysrt5uWqhElz3qD5fz2NHPdvi+OKLY/JP2Nlj
   IadJrEMwVZ0xyELJ6r4hVHh3x7UV9D1lBBb1vUainlb3Aao151bURJTt+
   qht+2nhzYhQhoBlpZ9dzxRDrkMmDF1kFAjxgXcDifdltPoT20exwropgx
   4ECEd9XnUkVvRST5cVWO25+VISOWsfhpKrnUDIRWeSzhw40MN+LISOu4v
   o8nv/+fDtF2oQkiW8TZGiPxE3M5/YQXOiEXnE6aZxfhsVPf0zFUTSyvqj
   w==;
IronPort-SDR: Y90vBjGuXvX5kF3Xf7L9ZtY1lHOBCUCi1VhnD/qs5668PxDqiqhoQ9yNnboghuA10oqazB6Ig9
 SJqzc++CXzlNcl8oqhRtJPrtZcRtdOvhCbgwWLzPEhD0DjZbMyRcpQaGFkjwYIocIp6YkKbruh
 J8R3g0MiDuHSZNtzucrU2RWjzG//LfFaoARL4bEUUc5VsicaCO+fP2zNH/SQtonRq5UFcCFkOU
 gFlhawGe51W3w+oHbjQmc0HbKe3pha0WgpSp/i+LcJgosn5PWD4S4cXTwrTdqdRU8wvneB3fP+
 T3qzVMecETG5dfqpgb9y32CE
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="146435799"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 01:51:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 01:51:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 01:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iueQrmhlu4U5hxZH0jCJZqu2ROV40AmIMiZoI0C/797OJjaQALQsXIAgJr1rNOyFMCk+ZjtbLqoV9S6p31MVo47cXfuzboHzIQp9CWONhcwsb/rgJ7bB/Am730QRo6dKaJK7RbPmhAXYzvfiEHnAJxfj/pv2fHzXOERGA/9nPEH4JkHdusY6vZLkv6eSOaYMlqVB7PuQ1jldSmPNvhslZLDenkyeBt/wNk/NT8DwDaPfjFJoHS+MEkDXK8ZZ9zlJ0H14angJfuweiBdrR0tNpELMH9flqHxTIsbnPYBzHSWREcwivVSqCSF4KfifbDnZkgOI2kHDpB7XTeVB7WzijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6tY5ZhDX7Wq26ik45c4+BxekC/9eLmFqyaRANWP7xg=;
 b=meOcZyKUfWczWOt3ax2YgLbghLJWPadLW7OIdnzu7OMQk8gjNMuGtnGCbxy2J6/WBaruetvzwm04MSasos2H5hev1FfSNGxVBpAW1UPUyc1CaFevQrps6VkXQdqtwm12+qtyw3+4tnoJvbPYUyzPlmmMGh9Y6MYqxjycA/MCNSy+uk1OD226HPnGV4lCrAb/PvZcPKZ6J0c/PrFWbCa2wtMNZ/0LNp7q6x0j2/ffEnaGqjbhJ4yhLBDxnw5KpPausz+gmwTB7rz7Rh+JbJThWxCNAexGS4QnttzWhz7AfK4UbgdFXf+IxBwQuvBBTMYy+pvKwzcPEMmOHKueWmaUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6tY5ZhDX7Wq26ik45c4+BxekC/9eLmFqyaRANWP7xg=;
 b=vV0AyZBXiyPeSyOyxA37D9yfAwGNordw9radkK1PEBqzyj24vhvqaOGugCaK92WDjCnxiJvn1B0Og8RYL8Gfp5LCp3jBHVTSLGc4ZlgnIqBuKZFTK0GyDeipYOr8IpYcaxwR8yPXwnd8xHFshg0Cvk9vsECtE6qHhpoqDZXkPs8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 08:51:25 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 08:51:25 +0000
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
Thread-Index: AQHX7/6cGW4RS1ZeJkC0M7VpsR3jOA==
Date:   Mon, 13 Dec 2021 08:51:25 +0000
Message-ID: <8523ca32-d36f-6e0b-0115-5e07553396f1@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
 <20211125090028.786832-9-tudor.ambarus@microchip.com>
 <Ybb/PV5M1Gi59s7I@matsya>
In-Reply-To: <Ybb/PV5M1Gi59s7I@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c599f0f-2ae9-480c-c1c2-08d9be15bee1
x-ms-traffictypediagnostic: SA0PR11MB4717:EE_
x-microsoft-antispam-prvs: <SA0PR11MB471742D1C5CCEF8ADC418BBEF0749@SA0PR11MB4717.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiTGDCG7UFlynEKJ7xINYSinycOi1v2isYQye3DsS+2SBSXcxa7pCgkOk0Ze9HCUhXpIcHKEoLnJZJFZfiwhMvWNL6sz19Lzpy9FiOtd2V1bxrZ1OHQeqne1d47CIFyaCQPKHDBSueCAQuJHeX+TCSfkZJostOY3VZ65JNZ+HYDpN5JCY7gbhs74za7FFdM6KwZLT07eiFknb6tgoptBy2/bzCdMcivu/XsMc8LFO5bTGrDrbKK2E05r2IQSG+nMAT67G1mZ7FbOrKHJUmT8x+UUIs0OsShE/Vy5u3CWyOEoCBAYDb7u3O3Idu9Tpkhr9TcCg8j1ya+eOG7pXUOtH29kkdG1+NDCqitorw9mrv3DYA2LKG0bD0U2bO9Iulv69g8gBSVNsBaMZ6/ENL3EnND2W8d0PPfZqZANHGdSJdhZ5Sh0qRz46ufdqAQvysXDV6ee/IOnmmCFxOZXpnRJfZ0GJ4DXfegsRkgfnnH3swr7ivzxrhN7QPgyV1FH/J2+ITBlxdTsbazDgeVoOLOsQasyNPYYfMT+pQ9c3aOTtlPazSWa4ss20eqxVoV/D6uwgpbUebADjK3XXK3n/witIWSBoTk8B6w7xCa7h7ImUVvSr+kYA9jXK9fTn6aRkxviKX4kK7rmOYwMcsOVsNnx+XMH/IbmHl58WRrXmHSbjJPM1+sSe+4knF0rWmnWqL7W0wAWe4jqdqszm+kc67okDR+zkoFEACQpHAAfuqjSVzh8f4srhWfejp0FIDIgEvRBa9xsRlNyrO8KrtG54xt76Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(5660300002)(508600001)(53546011)(38070700005)(71200400001)(6506007)(4744005)(7416002)(38100700002)(186003)(122000001)(8676002)(26005)(91956017)(316002)(66946007)(6512007)(36756003)(86362001)(31686004)(66446008)(2616005)(54906003)(64756008)(6916009)(6486002)(76116006)(66556008)(66476007)(2906002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05ZTjZQMjEyR0dETmlvYzZGWnVIQkhhL3dCVWRCaVFjNlpQejFadXhnUG1q?=
 =?utf-8?B?NWhFVlBmWklHOTNjL0NlVCtNK2hJN09XS0lzMW1ncjF2QklUc2FoQms5VXE3?=
 =?utf-8?B?K25mNkJPV1JoMzZQS3BsYnhzNmlqdjJCOFhtdCs3aEFBU2hCWmR1d25Yakw2?=
 =?utf-8?B?QS9oc0xnd3pJSnhiWjFldXZyeWVsajgxSmlRd2hhSWFrSmgybUZ3UVQvMk9a?=
 =?utf-8?B?WEdFeERvOFRmdVMrS3VUT0liczRteXE0ZUEyZjgxKzBXSjJWWDMyRmdyM3dH?=
 =?utf-8?B?b1U3ODFIUlR4M2hLUjBpS2xoK21vNXg3YW5ZcXVFbUZ1bWtEdHFLSnpTN3g5?=
 =?utf-8?B?UkRMazlZRDNCVXp2VWN2eVVTbXRlV3J4akdvYXBRNTY5c2t4ZkhFcDlYYXZ5?=
 =?utf-8?B?MGQwV21BYkZpTEVNZ3FLci8xeW9QdEFWNUpHak9FL3VYWjk3cHUrWjNtYzlH?=
 =?utf-8?B?djIxdnFuV0lmeldHZ2pDUTZqTE42dENJY1lTaWFJWUlocjV5SGtnNldOd1dt?=
 =?utf-8?B?ajB0cm1LdmgyOVM4VFlaT004V0JPdjRiWHZNNU1lbVFuSHpsWmlnNlpkNGxk?=
 =?utf-8?B?b3laTGphdVQxemR3Z1NUNHFReGhDUGo2QjIxQTZPeEFjQnQycVc3WS9kcjVC?=
 =?utf-8?B?blBRaERjRU5kWVlDUi85TmFGTEI1Q0NiUXg4SW94bXZHcDVyVU1NcUllWGNB?=
 =?utf-8?B?UHBVYVZId09Wci9YRis5cHE5M3lFZXJGQTlJbXNUdUhKcnpldGZLaVMyLzBY?=
 =?utf-8?B?Yy9naHNudWdrdkx6Zmtsc0g4Rmp4ZE9wdEtUOFJoQWJVVmtjdTdvVDh3QVE3?=
 =?utf-8?B?bGtNTElzcHRmTGhYVWZnVlBmMmxPRjA3NWJMRW9CbHk3eGNydVZvZG1xZVZZ?=
 =?utf-8?B?MkF1OC9KMExEKzM4aWJOa3BGSlFqbDZhWklDNEc1TWZuRTdIandLS3AyYmxw?=
 =?utf-8?B?cEJtdjNCbDlKWkRrT2dNU2UwSjhKVVN5ODBiNXVweW5Id1RHOW42KzE2d1JZ?=
 =?utf-8?B?SmFkd0lrNThuWHRlOXhOL2tUV0pHWFBUdUFJQWloYk84VzU4NFBKV2x2RUk4?=
 =?utf-8?B?ZGNScWxCMStlRXljdFhZd2pzblk5ZDhPU3UyY3MwZFY0c3hNTmRkYXhkWW1L?=
 =?utf-8?B?bm5DOTZIUWFtVkI4bm1vcTU1bHVkVHRncmZMcnhPSDJueGhLb3o1TStpcWtY?=
 =?utf-8?B?bTRTY1VIOElCOUNFQUkrRW9OYlVpanMrYmNjb01kcWRwTmppSE82dTJualV4?=
 =?utf-8?B?eDJGUmZKay91MkdGbjRWSHl4WnVTb0lqTUFHSCtBZ0V1eVpiV1dybHJscWZ2?=
 =?utf-8?B?MEFrUEwwNzF3amtUUjZldE1rajRJMHdvcXpSYk9hL29zb04vY3kwM0hyOHgy?=
 =?utf-8?B?bytZWDJReUk2VXB4TlY0b3BGYmFGRWFPK0x4T0FvaUxoci9rNVZaMG8rNHlm?=
 =?utf-8?B?QnVDVU85QWRPSVNOZHVab1E5bGtaVW9YN1lyNnN5VmZPbW8xbUNvZTJGMHo5?=
 =?utf-8?B?aU82Z0lnYnUrcVJiVTBjMVhlTEN4RWlmSG9pUVJ0TndVUHl0cmlHc3oxaDBJ?=
 =?utf-8?B?MXpFU1pWZjVJajFaNGhFNGxZYkkxa2ovbWpBZnJoSWc0Ull5V0VtY1RZVUN4?=
 =?utf-8?B?a2V3SFFqS01ZanU2SHRCTDFLTjhISUNMM0RKRExGeTF4Vk1TZWdxck9VbFBi?=
 =?utf-8?B?Q0NoeVhibEFPL1I3ZzFGdjJhaVpJb014RHJVY2RLM1V3SFVIalFCVVNTQ3hN?=
 =?utf-8?B?M21sSHdjWGFKdWExcDgxdVo5bEdDcFJqeVhheDFzYnZRaGVDOXBVYUtiMkxK?=
 =?utf-8?B?NHhHZ3psbmY1SHNUSkF3dW91T1RDMDBNbDE3V29hVGVQWGpaaVlmSURhOThL?=
 =?utf-8?B?Rk9LZ1d1Unh5UWRxcWpZeGVrbzNad0c0NDJFRndqdGdvUVlEMDVWazRsWk1Y?=
 =?utf-8?B?b01JYjdVNGxEd3NqTHpsTm9LS2tKSVdUYUNDTnlISXM3MlQyb0FObzBlOHhL?=
 =?utf-8?B?bG50eDl0dElkaU5xb3ZSWi94eGdUdDE5STM3VlI1aGhqWDNaN3dGSEcvdGV0?=
 =?utf-8?B?M21VWitVajRBdTdkRkpybE1kb25MK0QzREpmeVRuYks5VERtZ1lYc1FpYmhK?=
 =?utf-8?B?OFJxenhlMzFrcHAreDZhaUVHa3A5c09wZ3lHTWQ1YVNPOG96bkNZWkc0QUVC?=
 =?utf-8?B?MWU1WEo1TlcvdDRpN0ZHWkk0Ni9rckx1WWFxSVl5RzA4aVgzTkEwZUZRUGFx?=
 =?utf-8?B?eDFkSUkxZXl3LzFTTCtQdHdiVm1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6C0FACBBBE9274A81D1F99B7CCB4D27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c599f0f-2ae9-480c-c1c2-08d9be15bee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 08:51:25.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucF4Ey9PE9KbBUp9krX/F0TBMvcR1hR9BQZ4emnaR+RZcqmv/9r5w++DIJFq6S9QgnhAWHOWSVW4qRtOz8wBRcAP19pt4R4exICvtteXnVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIFZpbm9kLA0KDQpPbiAxMi8xMy8yMSAxMDowNyBBTSwgVmlub2QgS291bCB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNS0xMS0yMSwgMTE6
MDAsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBTbyB0aGF0IHdlIGRvbid0IHVzZSB0aGUgc2Ft
ZSBkZXNjIG92ZXIgYW5kIG92ZXIgYWdhaW4uDQo+IA0KPiBQbGVhc2UgdXNlIGZ1bGwgcGFyYSBp
biB0aGUgY2hhbmdlbG9nIGFuZCBub3QgYSBjb250aW51YXRpb24gb2YgdGhlDQo+IHBhdGNoIHRp
dGxlIQ0KDQpPaywgd2lsbCBhZGQgYSBiZXR0ZXIgY29tbWl0IGRlc2NyaXB0aW9uLiBIZXJlIGFu
ZCBpbiBvdGhlciBwYXRjaGVzIHdoZXJlDQp5b3VyIGNvbW1lbnQgYXBwbGllcy4NCg0KPiANCj4g
YW5kIHdoeSBpcyB3cm9uZyB3aXRoIHVzaW5nIHNhbWUgZGVzYyBvdmVyIGFuZCBvdmVyPyBBbnkg
YmVuZWZpdHMgb2Ygbm90DQo+IGRvaW5nIHNvPw0KDQpOb3Qgd3JvbmcsIGJ1dCBpZiB3ZSBtb3Zl
IHRoZSBmcmVlIGRlc2MgdG8gdGhlIHRhaWwgb2YgdGhlIGxpc3QsIHRoZW4gdGhlDQpzZXF1ZW5j
ZSBvZiBkZXNjcmlwdG9ycyBpcyBtb3JlIHRyYWNrLWFibGUgaW4gY2FzZSBvZiBkZWJ1Zy4gWW91
IHdvdWxkDQprbm93IHdoaWNoIGRlc2NyaXB0b3Igc2hvdWxkIGNvbWUgbmV4dCBhbmQgeW91IGNv
dWxkIGVhc2llciBjYXRjaA0KY29uY3VycmVuY3kgb3ZlciBkZXNjcmlwdG9ycyBmb3IgZXhhbXBs
ZS4gSSBzYXcgdmlydC1kbWEgdXNlcw0KbGlzdF9zcGxpY2VfdGFpbF9pbml0KCkgYXMgd2VsbCwg
SSBmb3VuZCBpdCBhIGdvb2QgaWRlYSwgc28gSSB0aG91Z2h0IHRvDQpmb2xsb3cgdGhlIGNvcmUg
ZHJpdmVyLg0KDQpDaGVlcnMsDQp0YQ0K
