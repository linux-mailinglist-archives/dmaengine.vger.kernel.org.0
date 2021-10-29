Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9A43F470
	for <lists+dmaengine@lfdr.de>; Fri, 29 Oct 2021 03:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJ2BnW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 21:43:22 -0400
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:39680
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229950AbhJ2BnV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 21:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHn/rf4lxDRtwUwerNOADjSexULXLKXMGCYNS0uIV/BcJCaYQLeFQjgTNGiHdIbLpov+ymvNb+raxKko/9LvFDRTgWIuwPPQN8rKPkgPecyNUZwiLbJIMcH7Pd5gBVcuF6tv3nKp6s7IUTW+wi/8kGD8K3LMkXRgWdYtMKGiuq1gLxk5QXdCE7YpR/8GxFpBfeZJ4Z04O8kiVgZrINdS3wlb3maVw/p6GYa0fXpKVNBhIf0SyZ7OMiGEbMdO2G2Axxoju9oz+02F5zy9GKIRzLkAMY6oEhkWMISjlxNlDYO5adxcU3yQVsLkytKqt5KuPIw1U0arpo0+uXz1qe6Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJAiOxXteEB8igSa/DmiGj2XF6DkIwGY19gYh92wUQs=;
 b=dHe4u4/x/RmzqsP4fFiWpiUc8E12sOf70Ay9VCDeVJo9jIP+HpkqvV6fadD+kJfcK4052KGYCji/6TBg5GQcBKZCVikOOMRGtXxvXev5A3pWxidjnyq4Jlzn3eTFw77/EgS2rR3WDHj3sOG1iM2YR8CKp+n93O7fiMEM90z001Nnf1xokT2OFlyxNABMZRu8EaLQRsJia6sAcTpN+fOa1TGYSbnoY18vO7JWGGkN9cqNa8xN0/6S4hkQWZxknqFuiokPw56S3dft8wcviYWLjEbSI2ce0qC9sKRSYa8ai/Avvk9H0OgKJrHP7PwjCIdn44kpyyCkpvEb5dvlXeU3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJAiOxXteEB8igSa/DmiGj2XF6DkIwGY19gYh92wUQs=;
 b=Q1frakSOOve5cnzKV52pCJIbW8/LkJ9pzb9WyfIpx+I7A3DOptQFWnd5q1GYP1Pv9BM43WS+1IkAXmQEV+oKL1AaOUp+z/QcYk1BQBLBDctptiSvDqobGnW6Zq21fg2blhjk2Sd8GTfANPfhY4KGaByVagiQP9bUJPu0LqYDPTI=
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM0PR04MB4865.eurprd04.prod.outlook.com (2603:10a6:208:c4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 01:40:45 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%6]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 01:40:45 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V4 1/1] dmaengine: fsl-edma: support edma memcpy
Thread-Topic: [EXT] Re: [PATCH V4 1/1] dmaengine: fsl-edma: support edma
 memcpy
Thread-Index: AQHXykgMI2p0ijteTEevnNeGQ8Jo46vorZCAgACJsSA=
Date:   Fri, 29 Oct 2021 01:40:45 +0000
Message-ID: <AM8PR04MB744434337950433E9096B711E1879@AM8PR04MB7444.eurprd04.prod.outlook.com>
References: <20211026090025.2777292-1-joy.zou@nxp.com>
 <YXrdebhLswRQ90EV@matsya>
In-Reply-To: <YXrdebhLswRQ90EV@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e41669dc-7ebc-437c-614c-08d99a7d2048
x-ms-traffictypediagnostic: AM0PR04MB4865:
x-microsoft-antispam-prvs: <AM0PR04MB48655FEFEB10C527809E5EB9E1879@AM0PR04MB4865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBq7e4gQwVkunm450dx+CA8l+8uZaK2PIH85+3tlbPA5x00xkXxnfjIqJRh8nZROemtdzdwdfkjEnoUbnOqD3SlOYmTyHoBsNAk2DTYrFkEruo4IfWbQUdhT+iyu7ODrXdPWAlTzheYaUdxMMjcFhZ7uFNk1H2uYEIfLRONFVDVvO0mKsR0aMaXNhZRIptREihYNInXbuj0NnWa6kQjqOchPouBbN0kes7OU3bjk8jXenGNdY1jjVfTfkuGqHTHG/G+6rsiip4O0LE1yAZM4YRcFxhGxaPaPhuVMFryWWwVHU8mQVvgdLmlA5PQoZbyLqHBBzFVl7CQOunnA2X3wTCOmN1r1GnySea0iFh+q62y1zf5DLkfMgD0v+YGV0rCEI8qonkyS1bv3dpz+MKgtcjLp6Up+obnR1vMlHsrqZxD9kKBP4rW+9s13QDLetCB89bhnK0uiSBOtVLISXlLMiVnygExf5GEMMvKqRPdmF7fMqRRUBVhXiz9i+OmI0G2zTtUL8Gfhba9M462Rh3CG8I0ocrS5oaaRf6oiuXGRe1T6COsGXKF9+9equwenXz3LaXXq8K49hROsdfyetdRUxFoE71s9ASDnlDS+75bP8PXLjmW/nB+RnBC9xrHExAgxe0QFvf/JWo91FH3aS0W8lBKwNPSez/btcXe1YrMeXv9mFBYoHu+nxWiXdvDRq8+mVLxc1NHM9VDjE6SGVsBthA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(4326008)(122000001)(4744005)(186003)(508600001)(33656002)(44832011)(52536014)(71200400001)(6916009)(5660300002)(26005)(2906002)(53546011)(6506007)(7696005)(86362001)(8676002)(66446008)(76116006)(66476007)(66556008)(64756008)(66946007)(8936002)(38070700005)(316002)(54906003)(9686003)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c2wvTlQrK01PSVVELzhMZU5KcllyRDFuOTNxS1BXTFowbU1IMlJ3UTMvaUxi?=
 =?gb2312?B?VUVlREhxaTJkM2tTeU8zbUVpVlhOcENVcXhRdU9zbjFNYWpTbG5sRmtWbCt4?=
 =?gb2312?B?NTE1RnNRWTcxa3JabXZGcHBobmlXMGdwelBqakk5U3hZQ0VrQnZ1UnpETDdZ?=
 =?gb2312?B?NkxVREpPRDd5bEN1bWNTTzFrMVZtWnFVWExZR0FlUWFUNlVqdUtIb1JiZ1JR?=
 =?gb2312?B?Uk1Ucm9uek83Y2pZRURkdXlPc1pISVRlNlJzT2NJVXBwcjY3MDhFZ3h0MFpI?=
 =?gb2312?B?djJ0Y0xyK3NuQXd1OHR2bDBUY1ljeVZIcGw2N0o0TEFyYXZpWDVpMk1vZ0Ew?=
 =?gb2312?B?UXN0ZXVwWnBXdnhPZXFiazdwRmRUVkk0dGZQYzZNWmtwZ2k1T1hxN0N5bnQx?=
 =?gb2312?B?MFNlbDY0S3dNbzZvYmdVbWlwQ0NLOHdpZ0NlQWNLTE9BeWVGK0xmTk03bjBz?=
 =?gb2312?B?TXpHR013c2FGakVTM2hZMWRBL1BLY2lKcTcwR1VBOWc0Q2F6VXNSOWNWVnRN?=
 =?gb2312?B?R2RKMjF4bXZSYmhFR0FjWUpDK1Jpa3JtellIY2tpckhoNUQ4clFWcVpaZVpD?=
 =?gb2312?B?bkYrRTdHNGJrazcxT21kcGNadGh0V1JDci81WVJIeXdHZTRGdjlpUzRWNjhP?=
 =?gb2312?B?dzlpdk96TXhaeVZkMTlsZkR5d3Z0NVpyTjZENndHK3lweHBENHBXRmZvNTNh?=
 =?gb2312?B?WWwwM3ZITCtZejVEcTc1MEwrS1pZeGkwRUVLWHBjK25lMnFhZWJaSHpWdjR3?=
 =?gb2312?B?TVFlYVJoMnpXd3B5Yi9aYnE1MitlT2dHS0JYRWhVNGx5OVBSODNiQ0pWSUNG?=
 =?gb2312?B?ZmpiZlZUU3R4dlBwSHYxUXQ4VEZuNVhoR2dIejcyeTNLcWZFcFAzSFFDRkJK?=
 =?gb2312?B?ZnBXWFYxZGRPOVd5NmwxaU9EblFUWGVQL3ZINnR4N2lZVFlNV0J5b1BadGl1?=
 =?gb2312?B?b2ZsMGdTdmVHZ1diOUtWZjVlMXdyTnZ1VEs1ZFZFWjRQSVFpQWRHbVE3N3RR?=
 =?gb2312?B?SzRhSXJpUTFncVV2RW1kaUtDS1pDd3VaRTU5aEtoNmsyQU0vOW9ZeUR2aUVB?=
 =?gb2312?B?LzdyZGtLSHg0M05wVTFrZDc2ZkNBM29wWmxsRDFHd1ZFcXNaYTRWUVRjMlV1?=
 =?gb2312?B?QWtETHMrem9uVWJIaFdISy95RWJYeFhuTlp3dFZESGRUSmZzcjU4Zkk2NnRu?=
 =?gb2312?B?TFVGVUx0dTNJN3haUEoyK3lEMndoZWNxWGpTMzc2U3lsWlhBTjBhNldkSFN1?=
 =?gb2312?B?ekRJNlVWYTFLVFZ0NzdLNHY5QzU2a09FTGJMWjExZnZKc2Z6STJxNU01aXBl?=
 =?gb2312?B?VXQyWDR2UVVaN1ZtaTErYkwrdzdtZDlEeXVOMmFyMFl5WHZRSUVCQkJweExN?=
 =?gb2312?B?aERDb255VUNuWWhNU3k3cDJRNjZPbnl0Z0dmUGdrVFVaT2hVcXBESW1DVlBQ?=
 =?gb2312?B?RHlBYjIzM2xTTTJtek9nM3YxTXZyYWFmSjduL0pjQkJXMUZnODZqQklWTUJz?=
 =?gb2312?B?VUxzeXI4N0NKRzVUN3Q3QnZRTUFkQ003ZnVEMGJ2ZkRZbUwzSkRGMzFkbXJ0?=
 =?gb2312?B?YnR2aUZET0pZL2hVckZmdS9QejJySldGWEpZRFZiRGwvQWVYZWQ5b1RKdkxt?=
 =?gb2312?B?Z2hldnozV25STWh3R2lGZktHeTBHc3lOQUpXNVhBdk14QjlNaXA4UzdHNmZs?=
 =?gb2312?B?SGZSUzc3aVc3VVhvb2pQcU1Jc1J6RXZWRG9ueVFiS1JyS09YTGEzdHBhTTVo?=
 =?gb2312?B?QlhWYTNzSVM2TGdQaS8zdnhkbUFPalcxRTB0NG1GZGh3Mk5NYUg3aDEraW5i?=
 =?gb2312?B?Ny9MMkY0NzZlYmcyVUc3MGJmd01URy96aW5TZEZrTzRXZFNreWF1cnYxMytP?=
 =?gb2312?B?eVlNRThrbXVsdVMzWkh4VHlISXVaRzlkU3Baek81R2pEM0paRStlVGUzaEhm?=
 =?gb2312?B?N1ROd01JWUhoMTZXeFd3YU00WnV2cG82bDV5bG44cHh6Z0gwZWZjY2JuTFRo?=
 =?gb2312?B?Ykg5NjBiQm5IT1hScWFlVG9pQXZHS2NJREFzT0dTV1RMVVNUMk93dUoxRldM?=
 =?gb2312?B?bXU1Y2Jpc1pCY3hCVVVMN21ITCtrYm9LbXFqZz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41669dc-7ebc-437c-614c-08d99a7d2048
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 01:40:45.1893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SX3P1rPWomZJdd8Nw5Pd1usTg6111sZMnyegJs2Q8aX8h1DaKbjgG5IPg/4Pz0ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4865
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhhbmtzIQ0KDQpCUg0KSm95IFpvdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4gDQpTZW50OiAyMDIxxOoxMNTCMjnI1SAx
OjI3DQpUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KQ2M6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggVjQgMS8xXSBkbWFlbmdp
bmU6IGZzbC1lZG1hOiBzdXBwb3J0IGVkbWEgbWVtY3B5DQoNCkNhdXRpb246IEVYVCBFbWFpbA0K
DQpPbiAyNi0xMC0yMSwgMTc6MDAsIEpveSBab3Ugd3JvdGU6DQo+IEFkZCBtZW1jcHkgaW4gZWRt
YS4gVGhlIGVkbWEgaGFzIHRoZSBjYXBhYmlsaXR5IHRvIHRyYW5zZmVyIGRhdGEgYnkgDQo+IHNv
ZnR3YXJlIHRyaWdnZXIgc28gdGhhdCBpdCBjb3VsZCBiZSB1c2VkIGZvciBtZW1vcnkgY29weS4g
RW5hYmxlIA0KPiBNRU1DUFkgZm9yIGVkbWEgZHJpdmVyIGFuZCBpdCBjb3VsZCBiZSB0ZXN0IGRp
cmVjdGx5IGJ5IGRtYXRlc3QuDQoNCkFwcGxpZWQsIHRoYW5rcw0KDQotLQ0KflZpbm9kDQo=
