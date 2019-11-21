Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479B9104762
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKUAPv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:15:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:22602 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKUAPg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="408325252"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2019 16:15:35 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 Nov 2019 16:15:35 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.73]) with mapi id 14.03.0439.000;
 Wed, 20 Nov 2019 16:15:34 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Thread-Topic: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Thread-Index: AQHVn+jQu1FBipL/xUihZzlSbMgW16eVIDmA//+R2QCAAIgqgP//htoQ
Date:   Thu, 21 Nov 2019 00:15:33 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4DA734@ORSMSX115.amr.corp.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic>
In-Reply-To: <20191120232645.GO2634@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjdkNzkzMzItOWQ2NC00NmUxLTg5ZTAtYjBmZjVhZDUzNjNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQndmUm1XVkM3QjVDWVlOMTJvcnJXaW5OZlA2TFdxTXBTYmxVWnN5dTVqaTVKeCtVdU5VYlgrMlMrWXh5NEJvZyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Pj4gV2hlbiB1c2luZyBkZWRpY2F0ZWQgcXVldWVzIHRoZSBjYWxsZXIgbXVzdCBrZWVwIGNvdW50
IG9mIGhvdyBtYW55DQo+PiBvcGVyYXRpb25zIGFyZSBpbiBmbGlnaHQgYW5kIG5vdCBzZW5kIG1v
cmUgdGhhbiB0aGUgZGVwdGggb2YgdGhlDQo+PiBxdWV1ZS4NCj4NCj4gVGhpcyB3YXk/DQoNClRo
YXQncyB0aGUgb25seSBwcmFjdGljYWwgd2F5LiBUaGUgZGV2aWNlIGRvZXMga2VlcCBhIGNvdW50
IG9mIGRyb3BwZWQNCmF0dGVtcHRzIC4uLiBzbyBpbiB0aGVvcnkgeW91IGNvdWxkIGdvIHJlYWQg
dGhhdCAuLi4gYnV0IHRoYXQgd291bGQgZ2l2ZSB1cA0KbXVjaCBvZiB0aGUgdmFsdWUgcHJvcG9z
aXRpb24gb2YgbG93IGNvc3QgdG8gc3VibWl0IHdvcmsgaWYgeW91IGhhZCB0byBkbw0KYW4gTU1J
TyByZWFkIGFmdGVyIGV2ZXJ5IHN1Ym1pc3Npb24uDQoNCi1Ub255DQo=
