Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2C53399E
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiEYJMh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiEYJMW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 05:12:22 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7513FB36C7;
        Wed, 25 May 2022 02:08:16 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Wed, 25 May
 2022 17:03:03 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.40]
Date:   Wed, 25 May 2022 17:03:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dmatest: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <12e4cf06.a35.180fa748c29.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAHEW_H8I1ibgY4AA--.645W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQARCmFEYxsloAAHsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguIFByZWZlcnJlZCBpcyBzdHJzY3B5LgoKU2lnbmVkLW9mZi1ieTog
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvZG1hL2RtYXRl
c3QuYyB8IDEyICsrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMgYi9kcml2
ZXJzL2RtYS9kbWF0ZXN0LmMKaW5kZXggZjY5NjI0NmY1N2ZkLi45MWJmNjVlMDY3NGMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZG1hL2RtYXRlc3QuYworKysgYi9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMK
QEAgLTEwOTUsOCArMTA5NSw4IEBAIHN0YXRpYyB2b2lkIGFkZF90aHJlYWRlZF90ZXN0KHN0cnVj
dCBkbWF0ZXN0X2luZm8gKmluZm8pCiAKIAkvKiBDb3B5IHRlc3QgcGFyYW1ldGVycyAqLwogCXBh
cmFtcy0+YnVmX3NpemUgPSB0ZXN0X2J1Zl9zaXplOwotCXN0cmxjcHkocGFyYW1zLT5jaGFubmVs
LCBzdHJpbSh0ZXN0X2NoYW5uZWwpLCBzaXplb2YocGFyYW1zLT5jaGFubmVsKSk7Ci0Jc3RybGNw
eShwYXJhbXMtPmRldmljZSwgc3RyaW0odGVzdF9kZXZpY2UpLCBzaXplb2YocGFyYW1zLT5kZXZp
Y2UpKTsKKwlzdHJzY3B5KHBhcmFtcy0+Y2hhbm5lbCwgc3RyaW0odGVzdF9jaGFubmVsKSwgc2l6
ZW9mKHBhcmFtcy0+Y2hhbm5lbCkpOworCXN0cnNjcHkocGFyYW1zLT5kZXZpY2UsIHN0cmltKHRl
c3RfZGV2aWNlKSwgc2l6ZW9mKHBhcmFtcy0+ZGV2aWNlKSk7CiAJcGFyYW1zLT50aHJlYWRzX3Bl
cl9jaGFuID0gdGhyZWFkc19wZXJfY2hhbjsKIAlwYXJhbXMtPm1heF9jaGFubmVscyA9IG1heF9j
aGFubmVsczsKIAlwYXJhbXMtPml0ZXJhdGlvbnMgPSBpdGVyYXRpb25zOwpAQCAtMTI0MCw3ICsx
MjQwLDcgQEAgc3RhdGljIGludCBkbWF0ZXN0X2NoYW5fc2V0KGNvbnN0IGNoYXIgKnZhbCwgY29u
c3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApCiAJCQkJZHRjID0gbGlzdF9sYXN0X2VudHJ5KCZp
bmZvLT5jaGFubmVscywKIAkJCQkJCSAgICAgIHN0cnVjdCBkbWF0ZXN0X2NoYW4sCiAJCQkJCQkg
ICAgICBub2RlKTsKLQkJCQlzdHJsY3B5KGNoYW5fcmVzZXRfdmFsLAorCQkJCXN0cnNjcHkoY2hh
bl9yZXNldF92YWwsCiAJCQkJCWRtYV9jaGFuX25hbWUoZHRjLT5jaGFuKSwKIAkJCQkJc2l6ZW9m
KGNoYW5fcmVzZXRfdmFsKSk7CiAJCQkJcmV0ID0gLUVCVVNZOwpAQCAtMTI2MywxNCArMTI2Mywx
NCBAQCBzdGF0aWMgaW50IGRtYXRlc3RfY2hhbl9zZXQoY29uc3QgY2hhciAqdmFsLCBjb25zdCBz
dHJ1Y3Qga2VybmVsX3BhcmFtICprcCkKIAkJaWYgKChzdHJjbXAoZG1hX2NoYW5fbmFtZShkdGMt
PmNoYW4pLCBzdHJpbSh0ZXN0X2NoYW5uZWwpKSAhPSAwKQogCQkgICAgJiYgKHN0cmNtcCgiIiwg
c3RyaW0odGVzdF9jaGFubmVsKSkgIT0gMCkpIHsKIAkJCXJldCA9IC1FSU5WQUw7Ci0JCQlzdHJs
Y3B5KGNoYW5fcmVzZXRfdmFsLCBkbWFfY2hhbl9uYW1lKGR0Yy0+Y2hhbiksCisJCQlzdHJzY3B5
KGNoYW5fcmVzZXRfdmFsLCBkbWFfY2hhbl9uYW1lKGR0Yy0+Y2hhbiksCiAJCQkJc2l6ZW9mKGNo
YW5fcmVzZXRfdmFsKSk7CiAJCQlnb3RvIGFkZF9jaGFuX2VycjsKIAkJfQogCiAJfSBlbHNlIHsK
IAkJLyogQ2xlYXIgdGVzdF9jaGFubmVsIGlmIG5vIGNoYW5uZWxzIHdlcmUgYWRkZWQgc3VjY2Vz
c2Z1bGx5ICovCi0JCXN0cmxjcHkoY2hhbl9yZXNldF92YWwsICIiLCBzaXplb2YoY2hhbl9yZXNl
dF92YWwpKTsKKwkJc3Ryc2NweShjaGFuX3Jlc2V0X3ZhbCwgIiIsIHNpemVvZihjaGFuX3Jlc2V0
X3ZhbCkpOwogCQlyZXQgPSAtRUJVU1k7CiAJCWdvdG8gYWRkX2NoYW5fZXJyOwogCX0KQEAgLTEy
OTUsNyArMTI5NSw3IEBAIHN0YXRpYyBpbnQgZG1hdGVzdF9jaGFuX2dldChjaGFyICp2YWwsIGNv
bnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwKQogCW11dGV4X2xvY2soJmluZm8tPmxvY2spOwog
CWlmICghaXNfdGhyZWFkZWRfdGVzdF9ydW4oaW5mbykgJiYgIWlzX3RocmVhZGVkX3Rlc3RfcGVu
ZGluZyhpbmZvKSkgewogCQlzdG9wX3RocmVhZGVkX3Rlc3QoaW5mbyk7Ci0JCXN0cmxjcHkodGVz
dF9jaGFubmVsLCAiIiwgc2l6ZW9mKHRlc3RfY2hhbm5lbCkpOworCQlzdHJzY3B5KHRlc3RfY2hh
bm5lbCwgIiIsIHNpemVvZih0ZXN0X2NoYW5uZWwpKTsKIAl9CiAJbXV0ZXhfdW5sb2NrKCZpbmZv
LT5sb2NrKTsKIAotLSAKMi4zNi4xCg==
