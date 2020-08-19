Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784924A1B1
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 16:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHSOZs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 10:25:48 -0400
Received: from mail2.skidata.com ([91.230.2.91]:49484 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgHSOZr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Aug 2020 10:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597847146; x=1629383146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YymJ3dZVzHVrgFLhK05T17oVu6zGDEJc8AVV1WphDOI=;
  b=ZNxDmnrukdDhezm7QxgtcjdoP/Qg9bW0JO/u3xXFHqEL6MaupcNfks3m
   z1THOqEhZKM/SZ6V1Dy6VHrg2vvs9CVwJ5rnbZg0GPrxMkTDfQmh7q+H3
   Z4jxBpQhxURIksGHV3y2C+qkMQsIQ+5smFvMw3kIZh3dFg9j7NGsrEfVr
   l04ek+c4cx4Ybtc+f7XZEq/OkakrR0/4D2cVlZsR44GrvzfTjr2pSAdA/
   n9uhKBKmzVq9cuUFyQOGSH2fqow/sYouCR33GUTIccVr3agNzvNK4HFSV
   UHsi59dx1DXCmOgiKSLyXqzf4sIOzdMDv+0jSahfORSEVmfdPtB6+WOje
   A==;
IronPort-SDR: 5PZhNmYKfRS1iEeazk3AUKjiex7CCBzJyiV0oe9bAGIFuqLnuWxvzOP+yOxygw0LMhZigOUvVQ
 Oh1reciiML1xT1TScCcBSeclRPTNjstksGsl+TaIVoY/ATKey4/zPptkdOvg8NSe9HjE+Aplpq
 1MT9V3sFQa6u1SNwc/G8gdgsx7/Qzw7/ajztXCosU35zxddFuAW/MmfTcXf6NY1TTIij3D0ApU
 GG6BpbvaK3nicyTS5nXQ5X+jOD3Lsz2K8yCeR7dm7AQ8AZWUn6LW097UuGtm1cDm93J6JoWuLM
 gYk=
X-IronPort-AV: E=Sophos;i="5.76,331,1592863200"; 
   d="scan'208";a="2645167"
From:   Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Robin Gong <yibin.gong@nxp.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQZKYOChL0mPkuCFeZyDJy6mKk3KiiAgABS1/CAB7DUgIAAV/7Q
Date:   Wed, 19 Aug 2020 14:25:43 +0000
Message-ID: <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
In-Reply-To: <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.111.252]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogTWl0dHdvY2gsIDE5LiBBdWd1c3QgMjAyMCAxMzow
OA0KPiBJIHRoaW5rIHRoaXMgbWlnaHQgYmUgYW4gc2RtYSBzcGVjaWZpYyBwcm9ibGVtIGFmdGVy
IGFsbC4NCj4gZG1hZW5naW5lX3Rlcm1pbmF0ZV9hc3luYygpIHdpbGwgaXNzdWUgYSByZXF1ZXN0
IHRvIHN0b3AgdGhlIERNQS4gQnV0IGl0DQo+IGlzIHN0aWxsIHNhZmUgdG8gaXNzdWUgdGhlIG5l
eHQgdHJhbnNmZXIsIGV2ZW4gd2l0aG91dCBjYWxsaW5nDQo+IGRtYWVuZ2luZV9zeW5jaHJvbml6
ZSgpLiBUaGUgRE1BIHNob3VsZCBzdGFydCB0aGUgbmV3IHRyYW5zZmVyIGF0IGl0cw0KPiBlYXJs
aWVzdCBjb252ZW5pZW5jZSBpbiB0aGF0IGNhc2UuDQo+IA0KPiBkbWFlZ2luZV9zeW5jaHJvbml6
ZSgpIGlzIHNvIHRoYXQgdGhlIGNvbnN1bWVyIGhhcyBhIGd1YXJhbnRlZSB0aGF0IHRoZQ0KPiBE
TUEgaXMgZmluaXNoZWQgdXNpbmcgdGhlIHJlc291cmNlcyAoZS5nLiB0aGUgbWVtb3J5IGJ1ZmZl
cnMpIGFzc29jaWF0ZWQNCj4gd2l0aCB0aGUgRE1BIHRyYW5zZmVyIHNvIGl0IGNhbiBzYWZlbHkg
ZnJlZSB0aGVtLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9ucyENCg0KPiBJIGRv
bid0IGtub3cgaG93IGZlYXNpYmxlIHRoaXMgaXMgdG8gaW1wbGVtZW50IGluIHRoZSBTRE1BIGRt
YWVuZ2luZQ0KPiBkcml2ZXIuIEJ1dCBJIHRoaW5rIHdoYXQgaXMgc2hvdWxkIGRvIGlzIHRvIGhh
dmUgc29tZSBmbGFnIHRvIGluZGljYXRlDQo+IGlmIGEgdGVybWluYXRlIGlzIGluIHByb2dyZXNz
LiBJZiBhIG5ldyB0cmFuc2ZlciBpcyBpc3N1ZWQgd2hpbGUNCj4gdGVybWluYXRlIGlzIGluIHBy
b2dyZXNzIHRoZSB0cmFuc2ZlciBzaG91bGQgZ28gb24gYSBsaXN0LiBPbmNlDQo+IHRlcm1pbmF0
ZSBmaW5pc2hlcyBpdCBzaG91bGQgY2hlY2sgdGhlIGxpc3QgYW5kIHN0YXJ0IHRoZSB0cmFuc2Zl
ciBpZg0KPiB0aGVyZSBhcmUgYW55IG9uIHRoZSBsaXN0Lg0KDQpJTUhPIHRoYXQncyBuZWFybHkg
d2hhdCBSb2JpbidzIHBhdGNoZXMgZG9lcywgc28gdGhpcyBzaG91bGQgYmUgc3VmZmljaWVudDoN
ClB1dHRpbmcgdGhlIGRlc2NyaXB0b3JzIHRvIGZyZWUgaW4gYW4gZXh0cmEgdGVybWluYXRpb24g
bGlzdCBhbmQgZW5zdXJpbmcNCnRoYXQgYSBuZXcgdHJhbnNmZXIgaXMgaGFuZGxlZCBhZnRlciB0
aGUgbGFzdCB0ZXJtaW5hdGlvbiBpcyBkb25lLg0KDQoNCkBSb2JpbjoNCklzIGl0IHBvc3NpYmxl
IHRvIHRhZyB0aGUgY29tbWl0cyBmb3IgdGhlIHN0YWJsZS10cmVlDQpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZz8NCg0KQmVzdCByZWdhcmRzIGFuZCB0aGFuayB5b3UgYWxsIQ0KQmVuamFtaW4N
ClJpY2hhcmQNCg0K
