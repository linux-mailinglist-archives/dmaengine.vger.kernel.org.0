Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786995A03E0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 00:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHXWVY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHXWVX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 18:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51F7B1F2
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661379680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kS0iq8dHOkfSr1AgnlMD2jSG2YdHB0OTxeML0xyuSPI=;
        b=A81yle+4IaYH25CocjrTvgRuA81ju/ZzFmS3SL/Nb9Z52Ff29reeM4OmS6SJYUANs0kjaa
        NLDl14xrFqF1rkdOOraCkNp1/g/3h5eeSNbR9f2C9XrJiCdy2HCy3DuPVqoI8MDPruojjT
        p/Us5MTwg56E+37h79f2XbnkQpJqyEg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-LTGIXaF7O3i3759MWY7JCA-1; Wed, 24 Aug 2022 18:21:19 -0400
X-MC-Unique: LTGIXaF7O3i3759MWY7JCA-1
Received: by mail-qt1-f198.google.com with SMTP id k9-20020ac80749000000b0034302b53c6cso14033245qth.22
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 15:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=kS0iq8dHOkfSr1AgnlMD2jSG2YdHB0OTxeML0xyuSPI=;
        b=Rjr6TEuUzM7JSmpi+Tyyqf3q8TcekRbzQxeFNXFlWZioqCaHbOeWsb09FY28/rHjgb
         Sg712qqY9zp1LIbtkPI/WUWpi8TGra1X8twGHS+Pt8l898O954Juk9jNBmbqHp10/3ut
         V68JpPx7/E0gnirc1u0oMfuEl0Zt5ixVBBAiUy5i8oCzzXVb8bjzBpl1FBLqjYJHZaWf
         OVlgp+fo+jlPDFTsc0BfLX1Tg3CSLbRvL2W4jFyfG9OCzeOmufx4UuJZLybZaRWaidYX
         GbdofONcMMpaN6blj/GgJmx9wVzpAw23g603SSzrohm7+1OYh1kFzOcFokx/AsQelQ18
         5V8Q==
X-Gm-Message-State: ACgBeo0S2/6E4Ibtrx3WweTonkVv4Sama9rsgrtPayee61JxuGVItr+i
        qWo38krhpFw2USOMYuvsBrB7CVj7gu8cAw8iQXVFnyN3bjfa9/5qpAGa14f06JC0aiwHC3GZW/P
        8CFCW2TsOW3dkt8JH9tQj
X-Received: by 2002:a05:6214:f27:b0:476:9d88:2597 with SMTP id iw7-20020a0562140f2700b004769d882597mr1159712qvb.45.1661379679347;
        Wed, 24 Aug 2022 15:21:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Hr7Bha2jaagHDS6H5xMurGZdvpKazJnLOGjlXWABgFxruccaUFYxF2938CmxLFRlGrwtR1A==
X-Received: by 2002:a05:6214:f27:b0:476:9d88:2597 with SMTP id iw7-20020a0562140f2700b004769d882597mr1159700qvb.45.1661379679140;
        Wed, 24 Aug 2022 15:21:19 -0700 (PDT)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 66-20020a370945000000b006b8d1914504sm14995163qkj.22.2022.08.24.15.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:21:18 -0700 (PDT)
Message-ID: <4ad689b727f8aabd4c01f13d66223fb00aa06dd4.camel@redhat.com>
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Date:   Wed, 24 Aug 2022 15:21:17 -0700
In-Reply-To: <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
         <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
         <20220824211625.mfcyefi5yvasdt4r@cantor>
         <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
         <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
         <36ecf274-7be1-f50e-8ac0-9e99bc9ef556@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE1OjE5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IAo+
IE9uIDgvMjQvMjAyMiAzOjA3IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4gT24gV2Vk
LCAyMDIyLTA4LTI0IGF0IDE0OjU5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+ID4gPiBPbiA4
LzI0LzIwMjIgMjoxNiBQTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiA+ID4gPiBPbiBXZWQs
IEF1ZyAyNCwgMjAyMiBhdCAwMToyOTowM1BNIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+ID4g
PiA+ID4gT24gOC8yNC8yMDIyIDEyOjI5IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4g
PiA+ID4gPiBGb3IgYSBzb2Z0d2FyZSByZXNldCBpZHhkX2RldmljZV9yZWluaXQoKSBpcyBjYWxs
ZWQsIHdoaWNoCj4gPiA+ID4gPiA+IHdpbGwKPiA+ID4gPiA+ID4gd2Fsawo+ID4gPiA+ID4gPiB0
aGUgZGV2aWNlIHdvcmtxdWV1ZXMgdG8gc2VlIHdoaWNoIG9uZXMgd2VyZSBlbmFibGVkLCBhbmQK
PiA+ID4gPiA+ID4gdHJ5Cj4gPiA+ID4gPiA+IHRvCj4gPiA+ID4gPiA+IHJlLWVuYWJsZSB0aGVt
LiBJdCBrZXlzIG9mZiB3cS0+c3RhdGUgYmVpbmcKPiA+ID4gPiA+ID4gaURYRF9XUV9FTkFCTEVE
LAo+ID4gPiA+ID4gPiBidXQgdGhlCj4gPiA+ID4gPiA+IGZpcnN0IHRoaW5nIGlkeGRfZW5hYmxl
X3dxKCkgd2lsbCBkbyBpcyBzZWUgdGhhdCB0aGUgc3RhdGUKPiA+ID4gPiA+ID4gb2YKPiA+ID4g
PiA+ID4gdGhlCj4gPiA+ID4gPiA+IHdvcmtxdWV1ZSBpcyBlbmFibGVkLCBhbmQgcmV0dXJuIDAg
aW5zdGVhZCBvZiBhdHRlbXB0aW5nIHRvCj4gPiA+ID4gPiA+IGlzc3VlCj4gPiA+ID4gPiA+IGEg
Y29tbWFuZCB0byBlbmFibGUgdGhlIHdvcmtxdWV1ZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IFNvIG9uY2UgYSB3b3JrcXVldWUgaXMgZm91bmQgdGhhdCBuZWVkcyB0byBiZSByZS1lbmFibGVk
LAo+ID4gPiA+ID4gPiBzZXQgdGhlIHN0YXRlIHRvIGRpc2FibGVkIHByaW9yIHRvIGNhbGxpbmcK
PiA+ID4gPiA+ID4gaWR4ZF9lbmFibGVfd3EoKS4KPiA+ID4gPiA+ID4gVGhpcyB3b3VsZCBhY2N1
cmF0ZWx5IHJlZmxlY3QgdGhlIHN0YXRlIGlmIHRoZSBlbmFibGUgZmFpbHMKPiA+ID4gPiA+ID4g
YXMgd2VsbC4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IENjOiBGZW5naHVhIFl1IDxmZW5naHVh
Lnl1QGludGVsLmNvbT4KPiA+ID4gPiA+ID4gQ2M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50
ZWwuY29tPgo+ID4gPiA+ID4gPiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4KPiA+
ID4gPiA+ID4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiA+ID4gRml4ZXM6
IGJmZTFkNTYwOTFjMSAoImRtYWVuZ2luZTogaWR4ZDogSW5pdCBhbmQgcHJvYmUgZm9yCj4gPiA+
ID4gPiA+IEludGVsCj4gPiA+ID4gPiA+IGRhdGEgYWNjZWxlcmF0b3JzIikKPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPiA+
ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+IMKgwqDCoCBkcml2ZXJzL2RtYS9pZHhkL2lycS5jIHwg
MSArCj4gPiA+ID4gPiA+IMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pZHhkL2lycS5j
Cj4gPiA+ID4gPiA+IGIvZHJpdmVycy9kbWEvaWR4ZC9pcnEuYwo+ID4gPiA+ID4gPiBpbmRleCA3
NDNlYWQ1ZWJjNTcuLjcyM2VlYjUzMjhkNiAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9kbWEvaWR4ZC9pcnEuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2RtYS9pZHhkL2lycS5j
Cj4gPiA+ID4gPiA+IEBAIC01Miw2ICs1Miw3IEBAIHN0YXRpYyB2b2lkIGlkeGRfZGV2aWNlX3Jl
aW5pdChzdHJ1Y3QKPiA+ID4gPiA+ID4gd29ya19zdHJ1Y3QgKndvcmspCj4gPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWR4ZF93cSAqd3EgPSBpZHhk
LT53cXNbaV07Cj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAod3EtPnN0YXRlID09IElEWERfV1FfRU5BQkxFRCkgewo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1Ff
RElTQUJMRUQ7Cj4gPiA+ID4gPiBNaWdodCBiZSBiZXR0ZXIgb2ZmIHRvIGluc2VydCB0aGlzIGxp
bmUgaW4KPiA+ID4gPiA+IGlkeGRfd3FfZGlzYWJsZV9jbGVhbnVwKCkuIEkKPiA+ID4gPiA+IHRo
aW5rIHRoYXQgc2hvdWxkIHB1dCBpdCBpbiBzYW5lIHN0YXRlLgo+ID4gPiA+IEkgZG9uJ3QgdGhp
bmsgdGhhdCBpcyBjYWxsZWQgaW4gdGhlIGNvZGUgcGF0aCB0aGF0IEkgd2FzIGxvb2tuZwo+ID4g
PiA+IGF0Lgo+ID4gPiA+IEkndmUgYmVlbgo+ID4gPiA+IGxvb2tpbmcgYXQgdGhpcyBiaXQgb2Yg
cHJvY2Vzc19taXNjX2ludGVycnVwdHMoKToKPiA+ID4gPiAKPiA+ID4gPiBoYWx0Ogo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoGdlbnN0cy5iaXRzID0gaW9yZWFkMzIoaWR4ZC0+cmVnX2Jhc2Ug
Kwo+ID4gPiA+IElEWERfR0VOU1RBVFNfT0ZGU0VUKTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoZ2Vuc3RzLnN0YXRlID09IElEWERfREVWSUNFX1NUQVRFX0hBTFQpIHsKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWR4ZC0+c3RhdGUgPSBJRFhEX0RFVl9I
QUxURUQ7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChnZW5z
dHMucmVzZXRfdHlwZSA9PQo+ID4gPiA+IElEWERfREVWSUNFX1JFU0VUX1NPRlRXQVJFKSB7Cj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
Kgo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogSWYgd2UgbmVlZCBhIHNvZnR3YXJlIHJlc2V0LCB3ZQo+ID4gPiA+IHdpbGwKPiA+ID4g
PiB0aHJvdyB0aGUgd29yawo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogb24gYSBzeXN0ZW0gd29ya3F1ZXVlIGluIG9yZGVyIHRvCj4g
PiA+ID4gYWxsb3cKPiA+ID4gPiBpbnRlcnJ1cHRzCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBmb3IgdGhlIGRldmljZSBjb21tYW5k
IGNvbXBsZXRpb25zLgo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICovCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBJTklUX1dPUksoJmlkeGQtPndvcmssCj4gPiA+ID4gaWR4ZF9k
ZXZpY2VfcmVpbml0KTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHF1ZXVlX3dvcmsoaWR4ZC0+d3EsICZpZHhkLT53b3JrKTsKPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlkeGQtPnN0YXRl
ID0gSURYRF9ERVZfSEFMVEVEOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWR4ZF93cXNfcXVpZXNjZShpZHhkKTsKPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlkeGRfd3FzX3Vu
bWFwX3BvcnRhbChpZHhkKTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9jaygmaWR4ZC0+ZGV2X2xvY2spOwo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWR4ZF9kZXZp
Y2VfY2xlYXJfc3RhdGUoaWR4ZCk7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZpZHhkLT5wZGV2LT5kZXYsCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgImlkeGQgaGFsdGVkLCBuZWVkICVzLlxuIiwKPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnZW5z
dHMucmVzZXRfdHlwZSA9PQo+ID4gPiA+IElEWERfREVWSUNFX1JFU0VUX0ZMUiA/Cj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIkZMUiIgOiAic3lzdGVtIHJlc2V0Iik7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmaWR4ZC0+ZGV2
X2xvY2spOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FTlhJTzsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiAKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ID4gPiB9Cj4gPiA+ID4gCj4gPiA+ID4gU28g
aXQgc2VlcyB0aGF0IHRoZSBkZXZpY2UgaXMgaGFsdGVkLCBhbmQgc3RpY2tzCj4gPiA+ID4gaWR4
ZF9kZXZpY2VfcmVpbmludCgpIG9uIHRoYXQKPiA+ID4gPiB3b3JrcXVldWUuIFRoZSBpZHhkX2Rl
dmljZV9yZWluaXQoKSBoYXMgdGhpcyBsb29wIHRvIHJlLWVuYWJsZQo+ID4gPiA+IHRoZQo+ID4g
PiA+IGlkeGQgd3FzOgo+ID4gPiBpZHhkX2RldmljZV9yZWluaXQoKSBzaG91bGQgY2FsbGVkIGlk
eGRfZGV2aWNlX3Jlc2V0KCkgZmlyc3QuIEFuZAo+ID4gPiB0aGF0Cj4gPiA+IHNob3VsZCBhdCBz
b21lIHBvaW50IGNhbGwgaWR4ZF93cV9kaXNhYmxlX2NsZWFudXAoKSBhbmQgY2xlYW4gdXAKPiA+
ID4gdGhlCj4gPiA+IHN0YXRlcy4KPiA+ID4gCj4gPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y2LjAtcmMyL3NvdXJjZS9kcml2ZXJzL2RtYS9pZHhkL2lycS5jI0w0Mgo+ID4g
PiAKPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzIvc291cmNl
L2RyaXZlcnMvZG1hL2lkeGQvZGV2aWNlLmMjTDcyNQo+ID4gPiAKPiA+ID4gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzIvc291cmNlL2RyaXZlcnMvZG1hL2lkeGQvZGV2
aWNlLmMjTDcxMQo+ID4gPiAKPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuMC1yYzIvc291cmNlL2RyaXZlcnMvZG1hL2lkeGQvZGV2aWNlLmMjTDM3Ngo+ID4gPiAKPiA+
ID4gU28gaWYgd2Ugc3RpY2sgdGhlIHdxIHN0YXRlIHJlc2V0IGluIHRoZXJlLCBpdCBzaG91bGQg
c2hvdyB1cCBhcwo+ID4gPiAiZGlzYWJsZWQiIGJ5IHRoZSB0aW1lIHdlIHRyeSB0byBlbmFibGUg
dGhlIFdRcyBhZ2Fpbi4gRG9lcyB0aGF0Cj4gPiA+IGxvb2sKPiA+ID4gcmVhc29uYWJsZT8KPiA+
ID4gCj4gPiBBaCwgeWVhaCBJIHNlZSB0aGF0IG5vdy4gU28sIGlmIGl0IGRvZXMgc2V0IHRoZSBz
dGF0ZSB0byBkaXNhYmxlZAo+ID4gaW4KPiA+IGlkeGRfd3FfZGlzYWJsZV9jbGVhbnVwKCksIGRv
ZXMgaXQgaGF2ZSBhbm90aGVyIG1lYW5zIHRvIHRyYWNrCj4gPiB3aGljaAo+ID4gd3FzIG5lZWQg
dG8gYmUgcmUtZW5hYmxlZCBmb3IgdGhhdCBsb29wIHRoYXQgaGFwcGVucyBhZnRlciB0aGUKPiA+
IGlkeGRfZGV2aWNlX3Jlc2V0KCkgY2FsbD8KPiAKPiBPaCBJIHNlZSB3aGF0IHlvdSBtZWFuLi4u
IFNvIHdlIGNhbiBlaXRoZXIgZG8gd2hhdCB5b3UgZGlkIG9yIGNyZWF0ZQo+IGEgCj4gbWFzayBh
bmQgbWFyayB0aGUgV1EgdGhhdCBhcmUgImVuYWJsZWQiIGJlZm9yZSByZXNldC4gTWF5YmUgdGhh
dCdzIAo+IGNsZWFuZXIgcmF0aGVyIHRoYW4gcmVseWluZyBvbiB0aGUgc2lkZSBlZmZlY3Qgb2Yg
dGhlIFdRIHN0YXRlIGlzbid0IAo+IGNsZWFyZWQ/IFRob3VnaHRzPwo+IAoKVGhhdCB3b3VsZCBi
ZSBiZXR0ZXIgSSB0aGluay4KCj4gCj4gPiAKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBmb3Ig
KGkgPSAwOyBpIDwgaWR4ZC0+bWF4X3dxczsgaSsrKSB7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpZHhkX3dxICp3cSA9IGlkeGQtPndxc1tpXTsKPiA+
ID4gPiAKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5z
dGF0ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1FfRElTQUJMRUQ7
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByYyA9IGlkeGRfd3FfZW5hYmxlKHdxKTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYyA8IDApIHsKPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfd2FybihkZXYsICJVbmFibGUgdG8gcmUtCj4gPiA+ID4gZW5hYmxlCj4gPiA+ID4gd3Eg
JXNcbiIsCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+IGRldl9uYW1l
KHdxX2NvbmZkZXYod3EpKSk7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoH0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gCj4gPiA+ID4gT25j
ZSB5b3UgZ28gaW50byBpZHhkX3dxX2VuYWJsZSgpIHRob3VnaCB5b3UgZ2V0IHRoaXMgY2hlY2sg
YXQKPiA+ID4gPiB0aGUKPiA+ID4gPiBiZWdpbm5pbmc6Cj4gPiA+ID4gCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsICJXUSAlZCBhbHJl
YWR5IGVuYWJsZWRcbiIsIHdxLQo+ID4gPiA+ID5pZCk7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+ID4gPiAKPiA+ID4gPiBTbyBJSVVDIGl0IHNlZXMgdGhlIGRldmljZSBpcyBoYWx0ZWQsIGdv
ZXMgdG8gcmVzZXQgaXQsIGZpZ3VyZXMKPiA+ID4gPiBvdXQKPiA+ID4gPiBhIHdxCj4gPiA+ID4g
c2hvdWxkIGJlIHJlLWVuYWJsZWQsIGNhbGxzIGlkeGRfd3FfZW5hYmxlKCkgd2hpY2ggaGl0cyB0
aGUKPiA+ID4gPiBjaGVjaywKPiA+ID4gPiByZXR1cm5zCj4gPiA+ID4gMCBhbmQgdGhlIHdxIGlz
IG5ldmVyIHJlYWxseSByZS1lbmFibGVkLCB0aG91Z2ggaXQgd2lsbCBzdGlsbAo+ID4gPiA+IGhh
dmUKPiA+ID4gPiB3cSBzdGF0ZQo+ID4gPiA+IHNldCB0byBJRFhEX1dRX0VOQUJMRUQuCj4gPiA+
ID4gCj4gPiA+ID4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KPiA+ID4gPiAKPiA+ID4gPiBS
ZWdhcmRzLAo+ID4gPiA+IEplcnJ5Cj4gPiA+ID4gCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBpZHhkX3dxX2VuYWJsZSh3
cSk7Cj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKHJjIDwgMCkgewo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2FybihkZXYs
ICJVbmFibGUgdG8KPiA+ID4gPiA+ID4gcmUtCj4gPiA+ID4gPiA+IGVuYWJsZSB3cSAlc1xuIiwK
PiAKCg==

