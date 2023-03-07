Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965DE6AE3B3
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCGPDN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 10:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCGPCg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 10:02:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9702396F1F;
        Tue,  7 Mar 2023 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678200666; x=1709736666;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r1dUJcozr+fM3DQbaDzTE4BCBoXoBC1lE+oOBvXW+R4=;
  b=J4c/HHDWUouew4Xjiu+9psA5YMUIcsgHjSe87EdxH3ZGlm5LFgB5mf/M
   AaKIO8sB3rIj1+FyCBo3NIsN9ndpG0gZ2O0kC5I3/JrXr3zIwjqAdkx3c
   TpiHhe4zQjJe5CjixVtYL6Ct/OKH2zv/MqWlVrijD3LNm4cNv5ypHa3T8
   IUSlthpcIBdbxaYZSjUWRWRQNTbkDkOWivTm+B7tekLySO5ktvMlYfC0T
   5U48CDKwdy4jnX+QSdqM0NJBA5nWSmOk3h06BuRAiRMA31emx1Z4tFv2Y
   l95TApfLGF1BesYKGhXToSrxt1hc0PYYuXqiIPQqCIcnioCeYxDFJqbLI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422138508"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="422138508"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 06:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819774602"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="819774602"
Received: from suchetam-mobl.amr.corp.intel.com ([10.212.53.59])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 06:50:48 -0800
Message-ID: <20a26cbe5404c420722f8dd39cf52ba7bb89bb9c.camel@linux.intel.com>
Subject: Re: [PATCH 01/16] dmaengine: idxd: add wq driver name support for
 accel-config user tool
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Tue, 07 Mar 2023 08:50:47 -0600
In-Reply-To: <c44caf95-6fe5-c336-e47e-d624e9c27054@intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
         <20230306185226.26483-2-tom.zanussi@linux.intel.com>
         <c44caf95-6fe5-c336-e47e-d624e9c27054@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgRmVuZ2h1YSwKCk9uIFR1ZSwgMjAyMy0wMy0wNyBhdCAwNTo0MyAtMDgwMCwgRmVuZ2h1YSBZ
dSB3cm90ZToKPiBIaSwgVG9tLAo+IAo+IE9uIDMvNi8yMyAxMDo1MiwgVG9tIFphbnVzc2kgd3Jv
dGU6Cj4gPiBGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4KPiA+IAo+ID4g
V2l0aCB0aGUgcG9zc2liaWxpdHkgb2YgbXVsdGlwbGUgd3EgZHJpdmVycyB0aGF0IGNhbiBiZSBi
b3VuZCB0bwo+ID4gdGhlIHdxLAo+ID4gdGhlIHVzZXIgY29uZmlnIHRvb2wgYWNjZWwtY29uZmln
IG5lZWRzIGEgd2F5IHRvIGtub3cgd2hpY2ggd3EKPiA+IGRyaXZlciB0bwo+ID4gYmluZCB0byB0
aGUgd3EuIEludHJvZHVjZSBwZXIgd3EgZHJpdmVyX25hbWUgc3lzZnMgYXR0cmlidXRlIHdoZXJl
Cj4gPiB0aGUgdXNlcgo+ID4gY2FuIGluZGljYXRlIHRoZSBkcml2ZXIgdG8gYmUgYm91bmQgdG8g
dGhlIHdxLiBUaGlzIGFsbG93cyBhY2NlbC0KPiA+IGNvbmZpZyB0bwo+ID4ganVzdCBiaW5kIHRv
IHRoZSBkcml2ZXIgdXNpbmcgd3EtPmRyaXZlcl9uYW1lLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFRv
bSBaYW51c3NpIDx0b20uemFudXNzaUBsaW51eC5pbnRlbC5jb20+Cj4gPiAtLS0KPiA+IMKgIC4u
Li9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZlci1kbWEtaWR4ZMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
NiArKysrCj4gPiDCoCBkcml2ZXJzL2RtYS9pZHhkL2NkZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKysrKwo+ID4gwqAgZHJpdmVycy9kbWEv
aWR4ZC9kbWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDYgKysrKwo+ID4gwqAgZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKwo+ID4gwqAgZHJpdmVycy9k
bWEvaWR4ZC9zeXNmcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMjgKPiA+ICsrKysrKysrKysrKysrKysrKysKPiA+IMKgIGluY2x1ZGUvdWFwaS9saW51eC9p
ZHhkLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiA+
IMKgIDYgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZlci1kbWEtaWR4ZAo+ID4gYi9E
b2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWRtYS1pZHhkCj4gPiBpbmRleCAz
YmVjYzlhODJiZGYuLmU5YTM3ZTA2NDE5MyAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
QUJJL3N0YWJsZS9zeXNmcy1kcml2ZXItZG1hLWlkeGQKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
QUJJL3N0YWJsZS9zeXNmcy1kcml2ZXItZG1hLWlkeGQKPiA+IEBAIC0yNDQsNiArMjQ0LDEyIEBA
IERlc2NyaXB0aW9uOsKgwqDCoMKgwqDCoMKgU2hvd3MgdGhlIG9wZXJhdGlvbgo+ID4gY2FwYWJp
bGl0eSBiaXRzIGRpc3BsYXllZCBpbiBiaXRtYXAgZm9ybWF0Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvcnJlbGF0ZXMgdG8gdGhlIG9wZXJhdGlvbnMgYWxsb3dlZC4gSXQn
cyB2aXNpYmxlCj4gPiBvbmx5Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9u
IHBsYXRmb3JtcyB0aGF0IHN1cHBvcnQgdGhlIGNhcGFiaWxpdHkuCj4gPiDCoCAKPiA+ICtXaGF0
OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvZHNhL2RldmljZXMvd3E8bT4uPG4+L2RyaXZl
cl9uYW1lCj4gPiArRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoEZlYiAyMywgMjAyMwo+ID4gK0tl
cm5lbFZlcnNpb246wqA2LjMuMAo+IAo+IE5lZWQgdG8gY2hhbmdlIHRvIDYuNC4wLiBUaGlzIHNl
cmllcyB3b24ndCBiZSBpbiA2LjMuMC4KCk9LLCB3aWxsIGNoYW5nZSB0byA2LjQuMC4KClRoYW5r
cywKClRvbQoKPiAKPiA+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZwo+ID4gK0Rlc2NyaXB0aW9uOsKgwqDCoE5hbWUgb2YgZHJpdmVyIHRvIGJlIGJvdW5k
ZWQgdG8gdGhlIHdxLgo+ID4gKwo+IAo+IFRoYW5rcy4KPiAKPiAtRmVuZ2h1YQoK

