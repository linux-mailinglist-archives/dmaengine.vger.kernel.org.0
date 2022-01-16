Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FC48FB56
	for <lists+dmaengine@lfdr.de>; Sun, 16 Jan 2022 08:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiAPHb6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 02:31:58 -0500
Received: from tkylinode-sdnproxy-1.icoremail.net ([139.162.70.28]:54706 "HELO
        tkylinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230116AbiAPHb6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 02:31:58 -0500
X-Greylist: delayed 6871 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jan 2022 02:31:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
        bh=3phafIXmRMQ5mJXI+ds71pFuhoEA9ECSPORZffJKggg=; b=N3No3k9RzU79u
        jmbEbpbaQC1mHEjf9YNszzC3/epkJU5lWFP+Gf26hQxWzohAIB2IcGdt/wSinWzm
        vsHqmwnnuzImNfusC2Soqq7w+VOryNqKblTQUeZufNOMNsxV2pU5FvChaksU2wRJ
        NZRwgqEMHopfzds4JFFsGKRfLWdZwg=
Received: by ajax-webmail-front02 (Coremail) ; Sun, 16 Jan 2022 15:29:51
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.17.95]
Date:   Sun, 16 Jan 2022 15:29:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     laurent.pinchart@ideasonboard.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: shdma: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6db72962.1929f.17e61cadc03.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 54FpogBXX9NvyeNhFqBYAA--.14453W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEEBlPy7t9+qgARsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

cG1fcnVudGltZV9nZXRfKCkgaW5jcmVtZW50cyB0aGUgcnVudGltZSBQTSB1c2FnZSBjb3VudGVy
IGV2ZW4Kd2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUsIHRodXMgYSBtYXRjaGluZyBkZWNy
ZW1lbnQgaXMgbmVlZGVkIG9uCnRoZSBlcnJvciBoYW5kbGluZyBwYXRoIHRvIGtlZXAgdGhlIGNv
dW50ZXIgYmFsYW5jZWQuCgpTaWduZWQtb2ZmLWJ5OiBZb25nemhpIExpdSA8bHl6X2NzQHBrdS5l
ZHUuY24+Ci0tLQogZHJpdmVycy9kbWEvc2gvc2hkbWEtYmFzZS5jIHwgNCArKystCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9kbWEvc2gvc2hkbWEtYmFzZS5jIGIvZHJpdmVycy9kbWEvc2gvc2hkbWEtYmFzZS5jCmlu
ZGV4IDE1OGU1ZTcuLmIyNmVkNjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hL3NoL3NoZG1hLWJh
c2UuYworKysgYi9kcml2ZXJzL2RtYS9zaC9zaGRtYS1iYXNlLmMKQEAgLTExNSw4ICsxMTUsMTAg
QEAgc3RhdGljIGRtYV9jb29raWVfdCBzaGRtYV90eF9zdWJtaXQoc3RydWN0IGRtYV9hc3luY190
eF9kZXNjcmlwdG9yICp0eCkKIAkJcmV0ID0gcG1fcnVudGltZV9nZXQoc2NoYW4tPmRldik7CiAK
IAkJc3Bpbl91bmxvY2tfaXJxKCZzY2hhbi0+Y2hhbl9sb2NrKTsKLQkJaWYgKHJldCA8IDApCisJ
CWlmIChyZXQgPCAwKSB7CiAJCQlkZXZfZXJyKHNjaGFuLT5kZXYsICIlcygpOiBHRVQgPSAlZFxu
IiwgX19mdW5jX18sIHJldCk7CisJCQlwbV9ydW50aW1lX3B1dChzY2hhbi0+ZGV2KTsKKwkJfQog
CiAJCXBtX3J1bnRpbWVfYmFycmllcihzY2hhbi0+ZGV2KTsKIAotLSAKMi43LjQK
